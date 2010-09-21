require 'test_helper'

class BraintreeBlueTest < Test::Unit::TestCase
  def setup
    @gateway = BraintreeGateway.new(fixtures(:braintree_blue))
  end

  def test_initialize_does_not_raise_an_error
    assert_nothing_raised do
      BraintreeBlueGateway.new(:merchant_id => "test", :public_key => "test", :private_key => "test")
    end
  end

  def test_refund
    Braintree::Transaction.expects(:refund).
      with('a_transaction_id', nil).
      returns(Braintree::SuccessfulResult.new)

    response = @gateway.credit(nil, 'a_transaction_id')
    assert_success response
  end

  def test_refund_with_partial_amount
    Braintree::Transaction.expects(:refund).
      with('a_transaction_id', '12.34').
      returns(Braintree::SuccessfulResult.new)

    response = @gateway.credit(1234, 'a_transaction_id')
    assert_success response
  end
end
