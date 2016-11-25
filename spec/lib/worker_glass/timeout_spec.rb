require 'spec_helper'

RSpec.describe WorkerGlass::Timeout do
  subject(:dummy_instance) { dummy_klass.new }

  let(:params_values) { Array.new(rand(10)) { rand } }
  let(:dummy_klass) do
    prepended = described_class

    ClassBuilder.build do
      prepend prepended

      self.timeout = 1

      def perform(*args)
        sleep(args.first)
        args.first * 2
      end
    end
  end

  describe '#perform' do
    context 'when timeout is defined and it runs fast enough' do
      let(:sleep_time) { 0 }

      it 'expect to run and return value of #perform' do
        expect(dummy_instance.perform(sleep_time)).to eq sleep_time * 2
      end
    end

    context 'when timeout is defined and it runs too slow' do
      let(:sleep_time) { 2 }

      it 'expect to fail with Timeout error' do
        error = WorkerGlass::Errors::TimeoutError
        expect { dummy_instance.perform(sleep_time) }.to raise_error error
      end
    end
  end

  context 'when timeout is not defined' do
    let(:dummy_klass) do
      prepended = described_class

      ClassBuilder.build do
        prepend prepended

        def perform(*args)
        end
      end
    end

    it 'expect to raise TimeoutNotDefined error' do
      expect { dummy_instance.perform }.to raise_error WorkerGlass::Errors::TimeoutNotDefined
    end
  end
end
