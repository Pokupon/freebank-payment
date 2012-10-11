require 'spec_helper'

describe FreebankPayment::CallbackResponse do

  it 'rejects if sign is invalid' do
    params = {
        :pay_amount => '10.00',
        :pay_order => '1234',
        :pay_goal => 'Best Product',
        :pay_bankid => '567890',
        :pay_datetime => '31.12.2000 10:00',
        :pay_test => '1',
        :pay_hash => 'wrong'
    }
    response = FreebankPayment::CallbackResponse.new 'secret', params
    response.valid?.should be_false
  end

  it 'accepts if sign is valid' do
      params = {
          :pay_amount => '10.00',
          :pay_order => '1234',
          :pay_goal => 'Best Product',
          :pay_bankid => '567890',
          :pay_datetime => '31.12.2000 10:00',
          :pay_test => '1',
          :pay_hash => 'd227f4689d792ca9003cefb3d7e471be4a012feb'
      }
      response = FreebankPayment::CallbackResponse.new 'secret', params
      response.valid?.should be_true
    end
end