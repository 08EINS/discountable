RSpec.describe Surcharge do

  subject { described_class }

  let(:amount) { Money.new(1000)}
  let(:percentage_amount) { 10 }
  let(:percentage) { Percentage.new percentage_amount }


  it 'should convert numeric percentage to Percentage class' do
    discount = subject.new amount, percentage_amount
    expect(discount.percentage).to be_a Percentage
  end

  it 'should convert numeric amount to money' do
    discount = subject.new 1000, Percentage.new(percentage_amount)
    expect(discount.original_price).to be_a Money
  end

  it 'should calculate the total price' do
    discount = subject.new amount, percentage
    expect(discount.total_price).to eq Money.new 1100
  end

  it 'should calculate the surcharge amount' do
    discount = subject.new amount, percentage
    expect(discount.surcharge_price).to eq Money.new 100
  end


end