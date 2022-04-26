Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # post url and shortcode
  post 'shorten', to: 'url_shortner#shortner'
  #  get shortcode
  get '/:shortcode', to: 'url_shortner#get_code'
  # get stats
  get '/:shortcode/stats', to: 'url_shortner#stats'

end
