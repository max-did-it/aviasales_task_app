max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
bind 'tcp://0.0.0.0:3000'
environment ENV.fetch('RAILS_ENV') { 'development' }

pidfile 'tmp/pids/server.pid'
state_path 'tmp/pids/puma.state'

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end

lowlevel_error_handler do |e|
  [500, {}, ['An error has occurred, and engineers have been informed. Please reload the page.']]
end