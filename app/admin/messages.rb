ActiveAdmin.register Message do

  # Global position
  # Position
  # Time
  # Stream Name
  # Type
  # Data
  # Metadata
  # Id
  #
 index do
    column :global_position do |msg|
      link_to msg.global_position, admin_message_path(msg)
    end
    column :position
    column :time
    column :stream_name do |msg|
      link_to msg.stream_name, admin_messages_path + "?q%5Bstream_name_equals%5D=#{msg.stream_name}&commit=Filter&order=global_position_desc"
    end
    column :type do |msg|
      link_to msg.type, admin_messages_path + "?q%5Btype_equals%5D=#{msg.type}&commit=Filter&order=global_position_desc"
    end
    column :data

    # String parsing because I could not get HTML escaping to work properly when updating the hash values
    column :metadata do |msg|
      unless msg.metadata.nil?
        data = msg.metadata.inspect
        stream_name = msg.metadata["causationMessageStreamName"]
        unless stream_name.nil?
          data.gsub!(/"causationMessageStreamName"=>"#{stream_name}"/, '"causationMessageStreamName"=>' + link_to(stream_name, admin_messages_path + "?q%5Bstream_name_equals%5D=#{stream_name}&commit=Filter&order=global_position_desc"))
        end
        global_position = msg.metadata["causationMessageGlobalPosition"]
        unless global_position.nil?
          puts data
          data.gsub!(/"causationMessageGlobalPosition"=>#{global_position}/, '"causationMessageGlobalPosition"=>' + link_to(msg.metadata["causationMessageGlobalPosition"], admin_message_path(msg.metadata["causationMessageGlobalPosition"])))
          puts data
        end
        raw(data)
      end
    end

    column :id
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :global_position, :position, :time, :stream_name, :type, :data, :metadata
  #
  # or
  #
  # permit_params do
  #   permitted = [:global_position, :position, :time, :stream_name, :type, :data, :metadata]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
