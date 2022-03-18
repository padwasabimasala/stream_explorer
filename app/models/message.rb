class Message < ApplicationRecord
  establish_connection :message_store
  self.inheritance_column = :_type_disabled

  def causation_message_global_position
    return unless metadata
    metadata["causationMessageGlobalPosition"]
  end

  def causation_message_stream_name
    return unless metadata
    metadata["causationMessageStreamName"]
  end

  def trace_id
    return unless metadata
    metadata.dig("properties", "traceId")
  end

  def causation_message
    Message.find_by_global_position causation_message_global_position
  end

  def ancestors
    unless @ancestors
      @ancestors = []

      cause = causation_message
      while not cause.nil? do
        @ancestors.append(cause)
        cause = cause.causation_message
      end
    end

    @ancestors
  end

  def descendants
    Message.where("extract(epoch from time::timestamp - ?::timestamp)/3600 between 0 and 1", time).where("(metadata->>'causationMessageGlobalPosition')::int = ?", global_position).order(:time).limit(10)
  end

  def stream_name_prefix
    stream_name.split('-').first
  end

end
