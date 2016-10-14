Rails.application.routes.draw do
	get '/intervals/all', to: 'intervals#all'
	get '/intervals/between', to: 'intervals#between'
end
