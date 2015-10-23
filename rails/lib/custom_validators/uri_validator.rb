require 'addressable/uri'
#Accepts options[:message] and options[:allowed_protocols]
class UriValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    value = uri_value(value)
    uri = parse_uri(value)
    if !uri
      record.errors[attribute] << generic_failure_message
    elsif !allowed_protocols.include?(uri.scheme)
      record.errors[attribute] << "must begin with #{allowed_protocols_humanized}"
    end
  end

  private

  def generic_failure_message
    options[:message] || "is an invalid URL"
  end

  def allowed_protocols_humanized
    allowed_protocols.to_sentence(:two_words_connector => ' or ')
  end

  def allowed_protocols
    @allowed_protocols ||= Array((options[:allowed_protocols] || ['http', 'https']))
  end

  def disallowed_protocols
    @disallowed_protocols ||= Array((options[:disallowed_protocols] || ['ftp', 'ssh']))
  end

  def parse_uri(value)
    uri = Addressable::URI.parse(value)
    uri.scheme && uri.host && uri
  rescue URI::InvalidURIError, Addressable::URI::InvalidURIError, TypeError
  end

  def uri_value(value)
    return value if disallowed_protocols.any? { |protocol| value.include?(protocol) }
    allowed_protocols.any? { |protocol| value.include?(protocol) } ? value : "http://#{value}"
  end

end