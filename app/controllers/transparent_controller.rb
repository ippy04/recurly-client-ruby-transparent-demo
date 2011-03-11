class TransparentController < ApplicationController
  before_filter :parse_results, :only => [:create_subscription, :create_transaction, :update_billing]

  def home
  end

  def result
    @return_results = flash[:transparent_post_result] || Recurly::Transparent.results(params)
  rescue Recurly::ValidationsFailed => ex
    @return_results = ex
  end

  def create_subscription
    @subscription = @result || Recurly::Subscription.new({
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
      :redirect_url => create_subscription_url,
      :account => {
        :account_code => "from_subscription_#{Time.now.to_i}",
      },
      :subscription => {
        :plan_code => "gold"
      },
    })
  end

  def create_transaction
    @transaction = @result || Recurly::Transaction.new({
      # initialize transaction fields (optional)

    })

    @transparent = Recurly::Transparent.new({
      :redirect_url => create_transaction_url,
      :account => {
        :account_code => "from_transaction_#{Time.now.to_i}"
      },
      :transaction => {
        :amount_in_cents => 500,
        :description => "A random charge"
      },

    })
  end

  def update_billing
    @billing_info = @result || Recurly::BillingInfo.new({
      # initialize billing fields (optional)

    })

    @transparent = Recurly::Transparent.new({
      :redirect_url => update_billing_url,
      :account => {
        :account_code => "456"
      },
    })
  end
  
  private
  
  def parse_results
    unless params[:result].blank?
      @result = Recurly::Transparent.results(params)
      
      if ['200','201'].include?(params[:status])
        # Success!
        flash[:transparent_post_result] = @result
        redirect_to result_url(
          :result => params[:result],
          :type => params[:type],
          :status => params[:status],
          :confirm => params[:confirm])
        return
      end
    else
      true
    end
  rescue Recurly::ValidationsFailed => ex
    @result = ex.model
  end
end
