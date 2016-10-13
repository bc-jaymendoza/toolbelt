require "#{Rails.root}/lib/my_task.rb"
Delayed::Worker.logger = Logger.new(Rails.root.join('log', 'dj.log'))


Delayed::Worker.destroy_failed_jobs = false



