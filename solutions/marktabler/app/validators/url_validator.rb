require 'addressable/uri'

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value

    begin
      uri = Addressable::URI.parse(value)

      unless ["http","https","ftp"].include?(uri.scheme)
        raise Addressable::URI::InvalidURIError
      end
    rescue Addressable::URI::InvalidURIError
      record.errors[attribute] << "is not a valid URL"
    end
  end
end
