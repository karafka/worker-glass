require 'spec_helper'

RSpec.describe SidekiqGlass::Worker do
  let(:return_value) { 10 }
  let(:param_value) { rand }
  let(:dummy_klass) do
    ClassBuilder.inherit(SidekiqGlass::Worker) do
      def execute(*_args)
        10
      end
    end
  end
  subject { dummy_klass.new }

  describe '::perform_async' do
    context 'when we dont provide any params' do
      it 'calls execute only once without params' do
        expect(dummy_klass)
          .to receive(:client_push)
          .with('class' => dummy_klass, 'args' => [])

        dummy_klass.perform_async
      end
    end
  end

  describe '#perform' do
    context 'when we dont set a timeout' do
      it 'should not use ::System::Timeout' do
        expect(:: SidekiqGlass::Timeout).to receive(:perform).never

        subject.perform(param_value)
      end

      it 'should return value of DummyWorker#execute' do
        expect(subject.perform(param_value)).to eq return_value
      end
    end

    context 'when we set a timeout' do
      let(:dummy_klass) do
        ClassBuilder.inherit(SidekiqGlass::Worker) do
          self.timeout = 2
          def execute(*_args)
            10
          end
        end
      end
      subject { dummy_klass.new }

      it 'should use ::SidekiqGlass::Timeout' do
        expect(:: SidekiqGlass::Timeout)
          .to receive(:perform).with(dummy_klass.timeout)

        subject.perform(param_value)
      end

      it 'should return return_value' do
        expect(subject.perform(param_value)).to eq return_value
      end
    end

    context 'when an exception is raised during #execute' do
      before { expect(subject).to receive(:execute).and_raise(StandardError) }

      context 'but after_failure method is not defined' do
        it 'should never execute after_failure and just reraise error' do
          expect { subject.perform(param_value) }.to raise_error StandardError
        end
      end

      context 'and after_failure method is defined' do
        let(:dummy_klass) do
          ClassBuilder.inherit(SidekiqGlass::Worker) do
            def execute(*_args)
              10
            end

            def after_failure(*args)
              puts args
            end
          end
        end
        subject { dummy_klass.new }

        it 'should execute after_failure, log fatal and just reraise error' do
          expect(subject).to receive(:puts).with([param_value])

          expect(SidekiqGlass::Worker)
            .to receive_message_chain(:logger, :fatal)

          expect { subject.perform(param_value) }.to raise_error StandardError
        end
      end
    end
  end
end
