Rails.application.routes.draw do
	root 'charts#main'

	get '/intervals/all', to: 'intervals#all'
	get '/intervals/between', to: 'intervals#between'
	get '/intervals/recent/:count', to: 'intervals#recent'
	get '/intervals/last', to: 'intervals#last'
end
