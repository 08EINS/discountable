RSpec.describe Percentage do

  subject { described_class.new 20 }

  it 'should initialize the amount as big decimal' do
    expect(subject.amount).to be_a BigDecimal
  end

  it 'should return the fraction' do
    expect(subject.fractional).to eq 0.2
    expect(subject.fractional).to be_a BigDecimal
  end

  it 'should have correct price factor' do
    expect(subject.price_factor).to eq 0.8
    expect(subject.price_factor).to be_a BigDecimal
  end

  context 'negative percentage' do
    it 'should not be allowed to have negative discounts' do
      expect { described_class.new -10 }.to raise_error ArgumentError
    end
  end


  # describe 'apply to price' do
  #
  #   it 'should apply discount to price' do
  #     expect(subject.apply_to(Money.from_amount(100))).to eq Money.from_amount(80)
  #   end
  #
  #   it 'should still be 0 if apply to 0 money' do
  #     expect(subject.apply_to(Money.from_amount(0))).to eq Money.from_amount(0)
  #   end
  #
  #   context '0 percent discount' do
  #     subject { described_class.new 0 }
  #
  #     it 'should stay the same price' do
  #       expect(subject.apply_to(Money.from_amount(100))).to eq Money.from_amount(100)
  #     end
  #   end
  #
  #   context 'negative price' do
  #
  #     it 'should raise argument error' do
  #       expect{subject.apply_to(Money.from_amount(-10))}.to raise_error ArgumentError
  #     end
  #
  #   end
  #
  #   context 'numeric value' do
  #     it 'should convert it to price' do
  #       expect(subject.apply_to(100)).to eq Money.from_amount 80
  #     end
  #   end
  #
  # end

  describe 'comparing discounts' do

    it 'should be equal with same amount' do
      expect(subject).to eq described_class.new 20
    end

    it 'should be less than discount with bigger amount' do
      expect(subject).to be < described_class.new(20.11)
    end

    it 'should be more than discount with smaller amount' do
      expect(subject).to be > described_class.new(19.999)
    end

  end

  describe 'type cast' do

    it 'should cast to float' do
      expect(subject.to_f).to eq 20.0
    end

    it 'should not raise argument errors when directly casting to float' do
      expect(Kernel.Float(subject)).to eq 20.0
    end

  end

end