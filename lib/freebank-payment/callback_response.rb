class FreebankPayment::CallbackResponse

  attr_reader :pay_amount, :pay_order, :pay_goal, :pay_bankid, :pay_datetime, :pay_test, :pay_hash

  def initialize(secret_key, input_params)
    @secret_key = secret_key
    @pay_amount = input_params[:pay_amount]
    @pay_order = input_params[:pay_order]
    @pay_goal = input_params[:pay_goal]
    @pay_bankid = input_params[:pay_bankid]
    @pay_datetime = input_params[:pay_datetime]
    @pay_test = input_params[:pay_test]
    @pay_hash = input_params[:pay_hash]
  end

  def valid?
    concat_str = [pay_amount, pay_order, pay_goal, pay_bankid, pay_datetime, pay_test, @secret_key].reduce('') { |result, element| result + (element || '') }
    expected_pay_hash = Digest::SHA1.hexdigest concat_str
    expected_pay_hash == @pay_hash
  end
end