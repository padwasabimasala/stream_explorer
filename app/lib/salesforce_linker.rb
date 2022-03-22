class SalesforceLinker
  def initialize(message)
    @message = message
  end

  def url_base
    'https://lvt.lightning.force.com/lightning/r/'
  end

  def links 
    if @message.stream_name && @message.stream_name.starts_with?('orderSfOpportunity')
      return {'Opportunity' => url_base + 'Opportunity/' + @message.stream_name.split('-')[1] + '/view'}
    end
    if @message.data.dig('orderItems', 0, 'orderId')
      return {'Order' => url_base + 'Order/' + @message.data.dig('orderItems', 0, 'orderId') + '/view'}
    end
    if @message.data.dig('account') && @message.data.dig('account').length == 18
      return {'Account' => url_base + 'Account/' + @message.data.dig('account') + '/view'}
    end
    # TODO billing account, shipping account from data
  end

end
