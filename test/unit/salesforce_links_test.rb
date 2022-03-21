require "test_helper"
require 'salesforce_linker'

class SalesforceLinkTest < ActiveSupport::TestCase
  test "it initializes" do
    SalesforceLinker.new
    m = Message.new id: 1234
    assert m.id == 1234
  end
end
