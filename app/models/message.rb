class Message < ApplicationRecord
  establish_connection :message_store
  self.inheritance_column = :_type_disabled

  def caused_messages
    # 220347
    Message.where( "(metadata->>'causationMessageGlobalPosition')::int = ?", global_position).limit(10) # add time constraint and order by
  end

  def causation_message_global_position
    metadata["causationMessageGlobalPosition"]
  end

  def causation_message_stream_name
    metadata["causationMessageStreamName"]
  end

  def trace_id
    metadata.dig("properties", "traceId")
  end

  def causation_message
    Message.find_by_global_position causation_message_global_position
  end

  def causation_history
    #@causation_history = [causation_message]

    unless false or @causation_history
      pp :building_causation_history
      @causation_history = []

      cause = causation_message
      pp cause_gp: causation_message_global_position
      pp cause: cause
      pp cause_nil: cause.nil?

      cnt = 0
      while not cause.nil? do
        pp cnt: cnt
        cnt += 1
        @causation_history.append(cause)
        cause = cause.causation_message
        pp next_cause: cause
      end
    end

    #pp causation_message_gp: causation_message_global_position
    #pp causation_message: causation_message
    pp causation_history_size: @causation_history.size

    @causation_history
  end

end
