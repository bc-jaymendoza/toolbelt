class FetchData
  include Delayed::RecurringJob
  include HTTParty

  queue 'workforce_api'
  timezone 'US/Central'
  run_every 1.minute

  def perform
		min_date = 240.minutes.ago
		max_date = Time.now

		url = "https://www.bcstoretools.com/api/v1/call_data?sort=asc&min_date=#{min_date.iso8601}&max_date=#{max_date.iso8601}"
		auth = {:username => ENV['API_USER'],
						:password => ENV['API_KEY']}

		HTTParty.get(url, :basic_auth => auth).each do |i|
			interval = Interval.find_by(api_id: i['id'])

			if interval
				# interval exists, so update it
        interval.update(calls_offered: i['calls_offered'],
                        calls_handled: i['calls_handled'])
			else
				# interval doesn't exist, so create it
				Interval.create(api_id: i['id'],
												calls_offered: i['calls_offered'],
												calls_handled: i['calls_handled'],
												timestamp: i['timestamp'])
			end
    end
  end
end
