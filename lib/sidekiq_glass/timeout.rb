# Module encapsulating Reentrant specific code
module SidekiqGlass
  # Timeout class
  class Timeout
    # Raised when timeout occurs
    class TimeoutError < StandardError; end

    # Executed given method and raises exception if it takes to much time
    # @param [Integer] time in seconds that we allow given block to run
    # @param [Block] block of code that we want to execute with timeout
    # @return Value returned by block
    # @raise [TimeoutError] error when method runs for too long
    # @example Execute a block of code for max 5 seconds
    #   ::System::Timeout.perform(5) do
    #     # code that should run max 5 seconds
    #   end
    def self.perform(time, &block)
      ::Timeout.timeout(time, TimeoutError) { block.call }
    end
  end
end
