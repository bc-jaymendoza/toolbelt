class IntervalsController < ApplicationController
	def all
		@intervals = Interval.all
		render json: @intervals
	end

	def between
		case params[:calls]
		when 'offered'
			@intervals = Interval.calls_offered(params[:min_date], params[:max_date])
		when 'handled'
			@intervals = Interval.calls_handled(params[:min_date], params[:max_date])
		end

		render json: @intervals
	end

	def recent
		min_date = Time.now.to_i - (params[:count].to_i * 900)
		max_date = Time.now.to_i

		@intervals = Interval.calls(min_date, max_date)
		render json: @intervals
	end
end
