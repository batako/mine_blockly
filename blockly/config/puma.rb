threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

rails_env = ENV.fetch("RAILS_ENV") { "development" }
environment rails_env

case rails_env
when "development"
  port ENV.fetch("PORT") { 3000 }
when "production"
  rails_root = File.expand_path("../..", __FILE__)
  sockets_path = ENV.fetch("SOCKETS_PATH") { "#{rails_root}/tmp/sockets" }
  bind "unix://#{sockets_path}/puma.sock"
  pidfile "#{rails_root}/tmp/pids/puma.pid"
  state_path "#{rails_root}/tmp/pids/puma.state"
  stdout_redirect "#{rails_root}/log/puma.stdout.log", "#{rails_root}/log/puma.stderr.log", true
end

plugin :tmp_restart
