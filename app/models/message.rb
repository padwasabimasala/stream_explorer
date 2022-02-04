class Message < ApplicationRecord
  establish_connection :message_store
  self.inheritance_column = :_type_disabled
end
