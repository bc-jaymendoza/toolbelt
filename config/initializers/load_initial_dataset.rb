#url = 'https://www.bcstoretools.com/api/v1/call_data?sort=asc'
#auth = {:username => ENV['API_USER'],
#        :password => ENV['API_KEY']}

#HTTParty.get(url, :basic_auth => auth).each do |i|
#  Interval.create(api_id: i['id'],
#	          calls_offered: i['calls_offered'],
#	          calls_handled: i['calls_handled'],
#	          timestamp: i['timestamp'])
#end

