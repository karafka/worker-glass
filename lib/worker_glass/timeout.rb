module WorkerGlass
  # This module provides additional timeout functionality for background processing engine
  # @example Example usage with Sidekiq - will fail with timeout error after 10 seconds
  #   class Worker
  #     include Sidekiq::Worker
  #     prepend WorkerGlass::Timeout
  #
  #     self.timeout = 10
  #
  #     def perform(*args)
  #       SlowService.new.run(*args)
  #     end
  #   end
  module Timeout
    # Adds a timeout class attribute to prepended class
    # @param base [Class] base class to which we prepend this module
    def self.prepended(base)
      base.class_attribute :timeout
    end

    # Executes a business logic with additional timeouts
    # @param args Any arguments that we passed when scheduling a background job
    # @raise [WorkerGlass::Errors::TimeoutNotDefined] if we didn't define timeout
    def perform(*args)
      fail Errors::TimeoutNotDefined unless self.class.timeout

      ::Timeout.timeout(self.class.timeout, Errors::TimeoutError) { super }
    end
  end
end
