require 'sidekiq_glass/version'

module SidekiqGlass
  # Base worker class for all other workers
  # @abstract Subclass can be used for all workers in app
  # @note Please use the execute method instead of perform - because of the extra
  #   reentracy layer that has been introduced. Also if you define additional
  #   after_failure method you can handle any timeout (or any other) errors and ensure
  #   reentrancy for your workers
  # @example Create a worker that will have a reentrancy for its task, that will
  #   run for max 15 seconds
  #
  #   class LazyWorker < SidekiqGlass::Worker
  #     self.timeout = 15
  #
  #     def execute(arg)
  #       # do some stuff here
  #     end
  #
  #    def after_failure(arg)
  #      # do something if there is a timeout or any other error
  #    end
  #  end
  class Worker
    include Sidekiq::Worker

    class << self
      attr_accessor :timeout
      attr_writer :logger

      # @return [Logger] logger that we want to use
      def logger
        @logger ||= ::SidekiqGlass::Logger.new
      end
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
      self.class.logger.fatal(exception)
      raise exception
    end
  end
end
