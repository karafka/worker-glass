# frozen_string_literal: true

%w[
  null_logger
  timeout
  active_support/core_ext/class/attribute
].each { |lib| require lib }

base_path = File.join(File.dirname(__FILE__), 'worker_glass')

%w[
  version
  errors
  timeout
  reentrancy
].each { |lib| require File.join(base_path, lib) }

# Background worker wrappers that provides optional timeout and after failure (reentrancy)
module WorkerGlass
  class << self
    attr_writer :logger

    # @return [Logger] logger that we want to use
    def logger
      @logger ||= NullLogger.new
    end
  end
end
