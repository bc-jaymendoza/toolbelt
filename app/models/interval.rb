class Interval < ApplicationRecord
	scope :created_between, ->(start_date, end_date) { where("timestamp >= ? AND timestamp <= ?", start_date, end_date) }
end
