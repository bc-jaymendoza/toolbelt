class IntervalsController < ApplicationController
	def all
		case params[:calls]
		when 'offered'
			@intervals = Interval.all_calls_offered
		when 'handled'
			@intervals = Interval.all_calls_handled
		end

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
		max_date = Time.now.to_i
		min_date = Time.now.to_i - (params[:count].to_i * 900)

		@intervals = Interval.recent(min_date, max_date)
		render json: @intervals
	end
end
