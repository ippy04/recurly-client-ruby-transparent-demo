TestTransparent::Application.routes.draw do
  get "create_subscription" => "transparent#create_subscription", :as => :create_subscription
  get "create_transaction" => "transparent#create_transaction", :as => :create_transaction
  get "update_billing" => "transparent#update_billing", :as => :update_billing
  get "result" => "transparent#result", :as => :result

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "transparent#home"

end
