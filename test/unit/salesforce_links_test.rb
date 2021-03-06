require "test_helper"
require 'salesforce_linker'

class SalesforceLinkTest < ActiveSupport::TestCase
  example_data_json = {"id"=>"8018a000000Ti2RAAS", "name"=>nil, "type"=>"New", "status"=>"Draft", "poNumber"=>nil, "sequence"=>471717, "isDeleted"=>nil, "orderItems"=>[{"id"=>"8028a000002HVNqAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471690, "unitPrice"=>32346.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.004Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000454", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"105109"}, {"id"=>"8028a000002HVNuAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471693, "unitPrice"=>0.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.080Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000458", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"103288"}], "description"=>nil, "orderNumber"=>"00000163", "billingEmail"=>"innovion.accountspayable@ii-vi.com", "customerName"=>"II-VI", "billingStreet"=>nil, "effectiveDate"=>nil, "opportunityId"=>"0068a00001FVuO3AAL", "processedTime"=>"2022-03-18T18:28:18.474Z", "customerClassC"=>"OTHER", "shipToAccountC"=>"0018a00001nGCnvAAG", "billingAccountC"=>"0018a00001maBpxAAE", "originalOrderId"=>nil, "billingStateCode"=>nil, "lastModifiedById"=>"0054W00000CLWe5QAH", "lastModifiedDate"=>"2022-03-18T18:09:18.000+0000", "billingPostalCode"=>nil, "billingCountryCode"=>"US", "orderReferenceNumber"=>nil}

  test "links defaults to an empty hash" do
    msg = Message.new
    linker = SalesforceLinker.new(msg)
    assert_equal({}, linker.links)
  end

  test "it parses the object from the stream name" do
    msg = Message.new stream_name: "orderSfOpportunity-0068a00001FVuO3AAL"
    linker = SalesforceLinker.new(msg)
    assert_equal({'Opportunity' => 'https://lvt.lightning.force.com/lightning/r/Opportunity/0068a00001FVuO3AAL/view'},
 linker.links)
  end

  test "it finds the account from the attributes" do
    msg = Message.new data: {'accountId' => '0018a00001maBpxAAE'}
    linker = SalesforceLinker.new(msg)
    assert_equal({'Account' => 'https://lvt.lightning.force.com/lightning/r/Account/0018a00001maBpxAAE/view'}, linker.links)
  end


  test "it parses the data json" do
    msg = Message.new data: example_data_json
    linker = SalesforceLinker.new(msg)
    assert_equal({'Order' => 'https://lvt.lightning.force.com/lightning/r/Order/8018a000000Ti2RAAS/view'}, linker.links)
  end



end

__END__
  	{"id"=>"8018a000000Ti2RAAS", "name"=>nil, "type"=>"New", "status"=>"Draft", "poNumber"=>nil, "sequence"=>471717, "isDeleted"=>nil, "orderItems"=>[{"id"=>"8028a000002HVNqAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471690, "unitPrice"=>32346.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.004Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000454", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"105109"},
 {"id"=>"8028a000002HVNuAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471693, "unitPrice"=>0.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.080Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000458", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"103288"},
 {"id"=>"8028a000002HVNvAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471695, "unitPrice"=>0.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.160Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000459", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"104660"},
 {"id"=>"8028a000002HVNrAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471697, "unitPrice"=>0.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.238Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000455", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"104403"},
 {"id"=>"8028a000002HVNsAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471699, "unitPrice"=>3000.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.306Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000456", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"104968"},
 {"id"=>"8028a000002HVNtAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471701, "unitPrice"=>0.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.384Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000457", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>"103849"},
 {"id"=>"8028a000002HVNpAAO", "orderId"=>"8018a000000Ti2RAAS", "quantity"=>1.0, "sequence"=>471703, "unitPrice"=>0.0, "createdById"=>"0054W00000CLWe5QAH", "description"=>nil, "processedTime"=>"2022-03-18T18:09:39.454Z", "billingAccountC"=>"0018a00001maBpxAAE", "orderItemNumber"=>"0000000453", "lastModifiedById"=>"0054W00000CLWe5QAH", "originalOrderItemId"=>nil, "productAcumaticaExternalIdC"=>nil}], "statusCode"=>"Draft", "billingCity"=>nil, "createdById"=>"0054W00000CLWe5QAH", "createdDate"=>"2022-03-18T18:09:16.000+0000", "description"=>nil, "orderNumber"=>"00000163", "billingEmail"=>"innovion.accountspayable@ii-vi.com", "customerName"=>"II-VI", "billingStreet"=>nil, "effectiveDate"=>nil, "opportunityId"=>"0068a00001FVuO3AAL", "processedTime"=>"2022-03-18T18:28:18.474Z", "customerClassC"=>"OTHER", "shipToAccountC"=>"0018a00001nGCnvAAG", "billingAccountC"=>"0018a00001maBpxAAE", "originalOrderId"=>nil, "billingStateCode"=>nil, "lastModifiedById"=>"0054W00000CLWe5QAH", "lastModifiedDate"=>"2022-03-18T18:09:18.000+0000", "billingPostalCode"=>nil, "billingCountryCode"=>"US", "orderReferenceNumber"=>nil}
