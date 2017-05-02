# frozen_string_literal: true

RSpec.describe WorkerGlass::Reentrancy do
  subject(:dummy_instance) { dummy_class.new }

  let(:param_value) { rand }
  let(:base_class) do
    prepended = described_class

    ClassBuilder.build do
      prepend prepended

      def perform(*args)
        run
        args.first * 2
      end

      def run
        10
      end

      def after_failure(*_); end
    end
  end
  let(:dummy_class) { base_class }

  describe '#perform' do
    context 'it runs without issues' do
      it 'expect to run and return value of #perform' do
        expect(dummy_instance.perform(param_value)).to eq param_value * 2
      end
    end

    context 'it fails to run' do
      let(:error) { StandardError }

      let(:dummy_class) do
        Class.new(base_class) do
          def run
            raise StandardError
          end
        end
      end

      it 'expect to log failure' do
        expect(WorkerGlass.logger).to receive(:fatal)
        expect { dummy_instance.perform(param_value) }.to raise_error error
      end

      it 'expect to run after_failure and reraise' do
        expect { dummy_instance.perform(param_value) }.to raise_error error
      end
    end
  end
end
