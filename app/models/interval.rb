class Interval < ApplicationRecord
	scope :created_between, ->(min_date, max_date) { where("timestamp >= ? AND timestamp <= ?", min_date, max_date) }

	def self.calls_offered(min_date, max_date)
		offered = created_between(min_date, max_date)
		offered.map {|i| [i.timestamp*1000, i.calls_offered]}
	end

	def self.calls_handled(min_date, max_date)
		handled = created_between(min_date, max_date)
		handled.map {|i| [i.timestamp*1000, i.calls_handled]}
	end
end
