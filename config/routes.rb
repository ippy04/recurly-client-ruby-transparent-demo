TestTransparent::Application.routes.draw do
  get "buy" => "pages#buy", :as => :buy
  get "buy_submit" => "pages#buy_submit", :as => :buy_submit

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "pages#home"

end
