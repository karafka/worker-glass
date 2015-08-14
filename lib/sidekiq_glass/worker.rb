require 'sidekiq_glass/version'

module SidekiqGlass
  # Worker
  class Worker
    include Sidekiq::Worker

    class << self
      attr_accessor :timeout
    end

    # @param args Any arguments that we can get from Sidekiq
    def perform(*args)
      if self.class.timeout
        ::SidekiqGlass::Timeout.perform(self.class.timeout) { execute(*args) }
      else
        execute(*args)
      end
    rescue => exception
      after_failure(*args) if respond_to?(:after_failure)
      raise exception
    end
  end
end
