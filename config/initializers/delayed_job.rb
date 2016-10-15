require "#{Rails.root}/lib/fetch_data.rb"
Delayed::Worker.logger = Logger.new(Rails.root.join('log', 'dj.log'))


Delayed::Worker.destroy_failed_jobs = false



