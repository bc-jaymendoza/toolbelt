class MyTask
  include Delayed::RecurringJob
  include HTTParty
  run_every 1.minutes
  #run_at '9:05pm'
  timezone 'US/Central'
  queue 'workforce_api'

  def perform
    url = 'https://www.bcstoretools.com/api/v1/call_data'
    #auth = {:username => ENV['API_USER'],
		#:password => ENV['API_KEY']}

    HTTParty.get(url, :basic_auth => auth).each do |i|
	 Interval.create(api_id: i['id'],
		      calls_offered: i['calls_offered'],
		      calls_handled: i['calls_handled'],
      		      timestamp: i['timestamp'])
    end


  end
end

# have two jobs -- one to get the main data dump, one to be the recurring job
# main data dump may just need to be an initializer, or not
#
#
# run_at can maybe be Time.now + a few (milli)seconds
