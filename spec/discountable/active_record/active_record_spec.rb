
class OrderMock < ActiveRecord::Base
  self.table_name = :order
  percentize :discount, :surcharge, validate: {less_or_equal_than: 100}
end

class OrderMockWithoutValidations < ActiveRecord::Base
  self.table_name = :order
  percentize :discount, validate: false
end

class OrderMockWithPostFix < ActiveRecord::Base
  self.table_name = :order
  percentize :discount, postfix: 'percent'
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

    it 'should persist the values' do
      subject.discount = 20
      subject.surcharge = 35
      expect{subject.save!}.not_to raise_error
      expect(OrderMock.first.discount).to eq Percentage.new(20)
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

      it 'should return percentage when its value is inside valid range' do
        subject.discount = 0
        expect(subject.discount).to eq Percentage.new

        subject.discount = 100
        expect(subject.discount).to eq Percentage.new 100
      end

    end

    context 'with postfix' do
      subject { OrderMockWithPostFix.new discount: 30 }

      it 'should respond to the method name with postfix' do
        expect(subject.respond_to?(:discount_percent)).to be_truthy
      end

      it 'should keep the original accessor' do
        expect(subject.discount).to be_a BigDecimal
      end
    end

    context 'disabled validation' do
      subject { OrderMockWithoutValidations.new }
      it 'should skip the validations' do
        expect(subject).to be_valid
      end
    end

  end



end