require 'spec_helper'

RSpec.describe WorkerGlass::Reentrancy do
  let(:param_value) { rand }
  let(:dummy_klass) do
    ClassBuilder.build do
      prepend WorkerGlass::Reentrancy

      def perform(*args)
        run
        args.first * 2
      end

      def run
        10
      end

      def after_failure(*_)
      end
    end
  end

  subject { dummy_klass.new }

  describe '#perform' do
    context 'it runs without issues' do
      it 'expect to run and return value of #perform' do
        expect(subject.perform(param_value)).to eq param_value * 2
      end
    end

    context 'it fails to run' do
      let(:error) { StandardError }

      before do
        expect(subject)
          .to receive(:run)
          .and_raise(error)
      end

      it 'expect to log failure' do
        expect(WorkerGlass.logger)
          .to receive(:fatal)

        expect { subject.perform(param_value) }.to raise_error error
      end

      it 'expect to run after_failure and reraise' do
        expect(subject)
          .to receive(:after_failure)
          .with(param_value)

        expect { subject.perform(param_value) }.to raise_error error
      end
    end
  end
end
