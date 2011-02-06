class PagesController < ApplicationController
  def home
  end

  def buy
    @subscription = Recurly::Subscription.new({
      :quantity => 1,
      :account => {
        :first_name => "d000d",
        :last_name => "man"
      }
    })

    @transparent = Recurly::Transparent.new({
      :redirect_url => buy_submit_url,
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

  def buy_submit
    @result = Recurly::Transparent.results(params)
  end

end
