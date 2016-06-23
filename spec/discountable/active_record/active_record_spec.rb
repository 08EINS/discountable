
class OrderMock < ActiveRecord::Base
  self.table_name = :order
  percentize :discount, :surcharge, validate: {less_or_equal_than: 100}
end

RSpec.describe OrderMock do

  describe 'initialization' do
    subject { described_class }

    it 'should be possible to instantiate' do
      expect {
        subject.new
      }.not_to raise_error
    end

  end

  describe 'percentize' do

    let(:percentage) { Percentage.new 50 }

    it 'should return 0 percent for discount and surcharge' do
      expect(subject.discount).to be_a Percentage
      expect(subject.surcharge).to be_a Percentage
    end

    it 'should be possible to assign numeric' do
      subject.discount = 50
      expect(subject.discount).to eq percentage
    end

    context 'with invalid percentage' do
      it 'should not be valid' do
        subject.discount = 200
        expect(subject).not_to be_valid
      end

      it 'should not be valid with negative percentage' do
        subject.discount = -1
        expect(subject).not_to be_valid
      end
    end

  end



end