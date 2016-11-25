require 'spec_helper'

# This file basically only requires stuff
RSpec.describe WorkerGlass do
  subject(:worker_glass) { described_class }

  it 'expect to be defined' do
    expect(defined?(worker_glass::VERSION)).to eq 'constant'
  end

  describe '#logger' do
    context 'when we set our custom logger' do
      let(:logger) { double }

      before do
        worker_glass.logger = logger
      end

      after do
        worker_glass.instance_variable_set(:@logger, nil)
      end

      it { expect(worker_glass.logger).to eq logger }
    end

    context 'when we dont set custom logger' do
      it { expect(worker_glass.logger).to be_a NullLogger }
    end
  end
end
