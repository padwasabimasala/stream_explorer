class Message < ApplicationRecord
  establish_connection :message_store
  self.inheritance_column = :_type_disabled

  def caused_messages
    #Dont work
    #where("time - ?::datetime < 1", time)
    #where("time - date(?) < 1", time)
    #

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
    unless @causation_history
      @causation_history = []

      cause = causation_message
      while not cause.nil? do
        @causation_history.append(cause)
        cause = cause.causation_message
      end
    end

    @causation_history
  end

end
