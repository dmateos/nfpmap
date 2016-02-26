class AbnLookup
  def initialize
    @guid = "86014b24-41e1-4dd5-ab16-f2cd2cfe4019"
    @wsdl = "http://www.abn.business.gov.au/abrxmlsearch/ABRXMLSearch.asmx?WSDL"
  end

  def find(type, options)
    @result = do_remote_request(type, options) 
    @result ? @result : false
  end

  private
  def do_remote_request(type, options)
    @soap_client ||= Savon.client(wsdl: @wsdl)

    case type
    when :name
      @result = @soap_client.call(:abr_search_by_name_simple_protocol, message: { 
        authentication_guid: @guid,
        name: options[:name], 
        postcode: options[:postcode] 
      })

      return get_abn_from_name_result(@result) if @result.success? and not get_response_from_name_result(@result).has_key?(:exception)
    end

    nil
  end

  def get_response_from_name_result(r)
    r.body[:abr_search_by_name_simple_protocol_response][:abr_payload_search_results][:response]
  end

  def get_abn_from_name_result(r)
    response = get_response_from_name_result(r)
    if response and response[:search_results_list]
      #wtf...
      if response[:search_results_list][:search_results_record].first.is_a?(Array)
        return response[:search_results_list][:search_results_record].first.last[:identifier_value]
      else
        return response[:search_results_list][:search_results_record].first[:abn][:identifier_value]
      end
    end
  end
end
