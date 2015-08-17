require 'sidekiq'

base_path = File.dirname(__FILE__) + '/sidekiq_glass'

%w( worker timeout version ).each do |file|
  require File.join(base_path, file)
end
