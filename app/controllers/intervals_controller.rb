class IntervalsController < ApplicationController
	def all
		@intervals = Interval.all
		render json: @intervals
	end

	def between
		@intervals = Interval.created_between(params[:min_date], params[:max_date])
		render json: @intervals
	end
end
