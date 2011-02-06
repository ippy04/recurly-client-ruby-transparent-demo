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
        :first_name => "d000d",
        :last_name => "man"
      }
    })

    @transparent = Recurly::Transparent.new({
      :redirect_url => result_url,
      :account => {
        :account_code => "aaa"
      },
      :subscription => {
        :plan_code => "AWESOME"
      },
      :transaction => {
        :type => "sale",
        :amount => 10.00
      }
    })
  end
end
