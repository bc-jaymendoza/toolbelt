Rails.application.routes.draw do
	root 'charts#main'
	get '/intervals/all', to: 'intervals#all'
	get '/intervals/between', to: 'intervals#between'
end
