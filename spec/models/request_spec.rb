require 'spec_helper'

describe FreebankPayment::Request do

  it 'rejects if payment amount is not a number' do
    request = FreebankPayment::Request.new
    request.pay_amount = 'wrong'
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_amount is not a number')
  end

  it 'rejects if payment amount is zero' do
    request = FreebankPayment::Request.new
    request.pay_amount = 0.0
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_amount must be greater than 0')
  end

  it 'rejects if payment amount is negative' do
    request = FreebankPayment::Request.new
    request.pay_amount = -1
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_amount must be greater than 0')
  end

  it 'rejects if payment order is not set' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_order is required')

    request.pay_order = ''
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_order is required')
  end

  it 'rejects if payment goal is not set' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_goal is required')

    request.pay_goal = ''
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_goal is required')
  end

  it 'rejects if success url is not set' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_success_url is required')

    request.pay_success_url = ''
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_success_url is required')
  end

  it 'rejects if success url is not valid' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    request.pay_success_url = 'example.com' # without http://
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_success_url is invalid')
  end

  it 'rejects if fail url is not set' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    request.pay_success_url = 'http://example.com/'
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_fail_url is required')

    request.pay_fail_url = ''
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_fail_url is required')
  end

  it 'rejects if fail url is not valid' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    request.pay_success_url = 'http://example.com'
    request.pay_fail_url = 'example.com'
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_fail_url is invalid')
  end

  it 'rejects if result url is not set' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    request.pay_success_url = 'http://example.com/'
    request.pay_fail_url = 'http://example.com/'
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_result_url is required')

    request.pay_result_url = ''
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_result_url is required')
  end

  it 'rejects if result url is not valid' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    request.pay_success_url = 'http://example.com'
    request.pay_fail_url = 'http://example.com'
    request.pay_result_url = 'example.com'
    lambda {
      request.params
    }.should raise_error(Exception, 'pay_result_url is invalid')
  end

  it 'rejects if provider is not set' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    request.pay_success_url = 'http://example.com/'
    request.pay_fail_url = 'http://example.com/'
    request.pay_result_url = 'http://example.com/'
    lambda {
      request.params
    }.should raise_error(Exception, 'provider is required')

    request.provider = ''
    lambda {
      request.params
    }.should raise_error(Exception, 'provider is required')
  end

  it 'rejects if secret key is not set' do
      request = FreebankPayment::Request.new
      request.pay_amount = 10
      request.pay_order = '1234567890'
      request.pay_goal = 'Best Product'
      request.pay_success_url = 'http://example.com/'
      request.pay_fail_url = 'http://example.com/'
      request.pay_result_url = 'http://example.com/'
      request.provider = '1234567890'
      lambda {
        request.params
      }.should raise_error(Exception, 'secret_key is required')

      request.secret_key = ''
      lambda {
        request.params
      }.should raise_error(Exception, 'secret_key is required')
    end

  it 'creates valid hash' do
    request = FreebankPayment::Request.new
    request.pay_amount = 10
    request.pay_order = '1234567890'
    request.pay_goal = 'Best Product'
    request.pay_success_url = 'http://example.com/'
    request.pay_fail_url = 'http://example.com/'
    request.pay_result_url = 'http://example.com/'
    request.provider = '1234567890'
    request.secret_key = '1234'
    request.params[:pay_hash].should == '72b0cf3466e8e06ded9201b04f81795452f0169a'
  end
end