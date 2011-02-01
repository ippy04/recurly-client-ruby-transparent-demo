class PagesController < ApplicationController
  def home
  end

  def buy
    @subscription = Recurly::Subscription.new({
      :quantity => 1
    })

    @account = Recurly::Account.new()

    @transparent = Recurly::Transparent.new({
      :redirect_url => buy_submit_url,
      :account => {
        :account_code => "aaa"
      },
      :subscription => {
        :plan_code => "DUDE"
      },
      :transaction => {
        :type => "sale",
        :amount => 10.00
      }
    })
  end

end
