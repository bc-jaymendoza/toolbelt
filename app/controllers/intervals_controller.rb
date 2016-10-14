class IntervalsController < ApplicationController
  def all
		@intervals = Interval.all
		render json: @intervals
  end
end
