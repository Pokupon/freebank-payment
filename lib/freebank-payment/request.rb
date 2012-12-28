require 'uri'

class FreebankPayment::Request

  attr_accessor :pay_amount, :pay_order, :pay_goal, :pay_success_url, :pay_fail_url, :pay_result_url, :pay_discountcard, :provider
  attr_accessor :secret_key

  def params
    validate!
    result = {
        :pay_amount => sprintf('%.2f', pay_amount),
        :pay_order => pay_order,
        :pay_goal => pay_goal[0, 160],
        :pay_success_url => pay_success_url,
        :pay_fail_url => pay_fail_url,
        :pay_result_url => pay_result_url,
        :pay_discountcard => pay_discountcard,
        :Provider => provider
    }
    result[:pay_hash] = Digest::SHA1.hexdigest(result[:pay_amount] + result[:pay_order] + result[:pay_goal] +
                                                   result[:pay_success_url] + result[:pay_fail_url] +
                                                   result[:pay_result_url] + result[:pay_discountcard] + result[:Provider] + secret_key).upcase
    result
  end

  private

  def validate!
    raise Exception.new('pay_amount is required') if pay_amount.nil?
    raise Exception.new('pay_amount is not a number') unless pay_amount.is_a? Numeric
    raise Exception.new('pay_amount must be greater than 0') if pay_amount.to_f <= 0
    raise Exception.new('pay_order is required') if pay_order.nil? || pay_order.empty?
    raise Exception.new('pay_goal is required') if pay_goal.nil? || pay_goal.empty?
    raise Exception.new('pay_success_url is required') if pay_success_url.nil? || pay_success_url.empty?
    raise Exception.new('pay_success_url is invalid') unless valid_url?(pay_success_url)
    raise Exception.new('pay_fail_url is required') if pay_fail_url.nil? || pay_fail_url.empty?
    raise Exception.new('pay_fail_url is invalid') unless valid_url?(pay_fail_url)
    raise Exception.new('pay_result_url is required') if pay_result_url.nil? || pay_result_url.empty?
    raise Exception.new('pay_result_url is invalid') unless valid_url?(pay_result_url)
    raise Exception.new('pay_discountcard is required') if pay_discountcard.nil?
    raise Exception.new('provider is required') if provider.nil? || provider.empty?
    raise Exception.new('secret_key is required') if secret_key.nil? || secret_key.empty?
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end