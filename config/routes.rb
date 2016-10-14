Rails.application.routes.draw do
	get '/intervals/all', to: 'intervals#all'
end
