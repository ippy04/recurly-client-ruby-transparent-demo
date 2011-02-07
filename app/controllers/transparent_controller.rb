class TransparentController < ApplicationController
  def home
  end

  def result
    @result = Recurly::Transparent.results(params)
  end

  def create_subscription
    @subscription = Recurly::Subscription.new({
      # initialize subscription (optional)
      :quantity => 1,
      :account => {

        :billing_info => {

          :credit_card => {

          }
        }
      },
    })

    @transparent = Recurly::Transparent.new({
      :redirect_url => result_url,
      :account => {
        :account_code => "from_subscription"
      },
      :subscription => {
        :plan_code => "AWESOME"
      },
      :billing_info => {
        :ip_address => request.remote_addr
      }
    })
  end

  def create_transaction
    @transaction = Recurly::Transaction.new({
      # initialize transaction fields (optional)

    })

    @transparent = Recurly::Transparent.new({
      :redirect_url => result_url,
      :account => {
        :account_code => "from_transaction_#{Time.now.to_i}"
      },
      :transaction => {
        :amount_in_cents => 500,
        :description => "A random charge"
      },
      :billing_info => {
        :ip_address => request.remote_addr
      }

    })
  end

  def update_billing
    @billing_info = Recurly::BillingInfo.new({
      # initialize billing fields (optional)

    })

    @transparent = Recurly::Transparent.new({
      :redirect_url => result_url,
      :account => {
        :account_code => "from_billing"
      },
      :billing_info => {
        :ip_address => request.remote_addr
      }
    })
  end
end
