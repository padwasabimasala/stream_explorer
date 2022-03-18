ActiveAdmin.register Message do
  actions :index, :show

  # Global position
  # Position
  # Time
  # Stream Name
  # Type
  # Data
  # Metadata
  # Id

 index do
    column :global_position do|msg|
      link_to msg.global_position, admin_message_path(msg)
    end
    column :position
    column :time
    column :stream_name do|msg|
      link_to msg.stream_name, admin_messages_path + "?q%5Bstream_name_equals%5D=#{msg.stream_name}&commit=Filter&order=global_position_desc"
    end
    column :type do|msg|
      link_to msg.type, admin_messages_path + "?q%5Btype_equals%5D=#{msg.type}&commit=Filter&order=global_position_desc"
    end
    column :data do|msg|

      part = msg.data.first(3).to_h
      part.inspect[0..-1] + " ... }"
    end

    # String parsing because I could not get HTML escaping to work properly when updating the hash values
    column :metadata do|msg|
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

    # Helpful for development purposes but no in production because query had no index and is expensive
    # column :prev do|msg|
    #   msg.ancestors.size
    # end
    # column :next do|msg|
    #   msg.descendants.size
    # end
  end

 show title: proc {|msg| "#{msg.type} (#{msg.stream_name_prefix}) - #{msg.global_position}"} do
    #h2 {"#{message.stream_name}"}

    render 'other'

    panel "Attributes" do
      table_for message do
        column :type
        column :stream_name
        column :global_position
        column :time
        column :position
      end
    end

    panel "Data" do
      attributes_table_for message.data do
        # TOdosort as strings, numbers, dates, bools
        message.data.keys.sort.each do|key|
          row key
        end
      end
    end

    panel "MetaData", only: :show  do
      attributes_table_for message.metadata do
        message.metadata.keys.sort.each do|key|
          row key
        end
      end
    end

    panel "Ancestors Detail" do
      table_for message.ancestors.reverse do
        column :global_position
        column :stream_name
        column :type
      end
    end

    panel "Descendants" do
      table_for message.descendants do|msg|
        column :global_position
        column :stream_name
        column :type
      end
    end

    panel "Message Stream" do
      div(class: 'flex-wrapper') do
        message.ancestors.reverse.each do|msg|
          div(class: 'box arrow-bottom flex-size-2') do
            #h2{ raw "#{msg.stream_name_prefix} &rarr; #{msg.type} - #{link_to msg.global_position,  admin_message_path(msg) }"}
            render 'card', locals: { msg: msg }
          end
        end

        div(class: 'box flex-size-2') do
          #h2{ raw "#{message.stream_name_prefix} &rarr; #{message.type} - #{link_to message.global_position,  admin_message_path(message) }"}
          render 'card', locals: { msg: @message }
        end

        message.descendants.each do|msg|
          div(class: 'box arrow-top flex-size-1') do
            #h2{ raw "#{msg.stream_name_prefix} &rarr; #{msg.type} - #{link_to msg.global_position,  admin_message_path(msg) }"}
            render 'card', object: msg
          end
        end
      end
    end

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
