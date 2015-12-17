require 'spec_helper'

# This file basically only requires stuff
RSpec.describe WorkerGlass do
  subject { described_class }

  it 'expect to be defined' do
    expect(defined?(subject::VERSION)).to eq 'constant'
  end

  describe '#logger' do
    context 'when we set our custom logger' do
      let(:logger) { double }

      before do
        subject.logger = logger
      end

      after do
        subject.instance_variable_set(:@logger, nil)
      end

      it { expect(subject.logger).to eq logger }
    end

    context 'when we dont set custom logger' do
      it { expect(subject.logger).to be_a NullLogger }
    end
  end
end
