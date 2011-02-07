class TransparentController < ApplicationController
  def home
  end

  def result
    @result = Recurly::Transparent.results(params)
  end

  def create_subscription
    @subscription = Recurly::Subscription.new({
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
        :account_code => "aaa"
      },
      :subscription => {
        :plan_code => "AWESOME"
      },
      :billing_info => {
        :ip_address => request.remote_addr
      },
      :transaction => {
        :type => "sale",
        :amount => 10.00
      }
    })
  end
end
