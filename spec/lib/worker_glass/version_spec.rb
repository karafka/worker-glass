require 'spec_helper'

RSpec.describe WorkerGlass do
  it { expect { described_class::VERSION }.to_not raise_error }
end
