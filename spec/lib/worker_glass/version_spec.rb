# frozen_string_literal: true

RSpec.describe WorkerGlass do
  it { expect { described_class::VERSION }.not_to raise_error }
end
