require 'sidekiq_glass'
RSpec.describe SidekiqGlass::Timeout do
  describe '::perform' do
    context 'block call takes less time than specified' do
      let(:block) { proc { 1 + 1 } }
      let(:time) { 10 }

      it 'returns result from calling block' do
        expect(described_class.perform(time, &block)).to eq 2
      end
    end

    context 'block call takes more time than specified' do
      let(:time) { 0.000001 }
      let(:block) { proc { sleep(1) } }

      it 'raises TimeoutError' do
        expect do
          described_class.perform(time, &block)
        end.to raise_error(described_class::TimeoutError)
      end
    end
  end
end
