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

  def utc_time
    time
  end

  def mst_time
    time.in_time_zone("MST") + 1.hour # Daylight
  end

  def link_to_logs
    start_time = time - 1.minute
    end_time = time + 1.minute
    "https://us-west-2.console.aws.amazon.com/cloudwatch/home?region=us-west-2#logsV2:log-groups/log-group/$252F#{component_name}/log-events$3Fstart$3D#{start_time}$26end$3D#{end_time}"
  end

  def component_name
    case
    when stream_name.include?('order')
      #contains order is order component
      "order-component"
    when stream_name.include?('acumatica')
      # probably just contains acumatica customer
      "acumatica-customer-component"
    when stream_name.include?('salesforce') || stream_name.include?('sfimport')
      "salesforce-import-component"
      # probably just contains salesforce import
    when stream_name.include?('location')
      # will contain location
      "location-component"
    else
      "idk"
    end
  end

end
