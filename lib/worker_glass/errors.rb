# frozen_string_literal: true

module WorkerGlass
  # Module enclosing all the errors that might be raised from this library
  module Errors
    # Base class for all the WorkerGlass internal errors
    class BaseError < StandardError; end
    # Raised when we use Timeout feature and timeout occurs
    class TimeoutError < BaseError; end
    # Raised when we use Timeout feature but we don't specify default timeout
    class TimeoutNotDefined < BaseError; end
  end
end
