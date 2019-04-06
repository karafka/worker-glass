# frozen_string_literal: true

module WorkerGlass
  # This module provides a reentrancy functionality for background processing engine
  # @note If will reraise a given error - it does not silence them
  # @example Example usage with Sidekiq - if something fails, after_failure will be executed
  #   class Worker
  #     include Sidekiq::Worker
  #     prepend WorkerGlass::Reentrancy
  #
  #     def perform(*args)
  #       FailingService.new.run(*args)
  #     end
  #
  #     def after_failure(*args)
  #       FailingService.new.reset(*args)
  #     end
  #   end
  module Reentrancy
    # Executes a business logic with additional timeouts
    # @param args Any arguments that we passed when scheduling a background job
    def perform(*args)
      super
    rescue StandardError => e
      WorkerGlass.logger.fatal(e)
      after_failure(*args)
      raise e
    end
  end
end
