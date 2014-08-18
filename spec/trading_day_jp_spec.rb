require 'spec_helper'

describe TradingDayJp do
  describe '.open?' do
    context 'given 2014-08-28' do
      it { expect(TradingDayJp.open? Date.new(2014, 8, 28)).to eq true }
    end

    context 'given 2016-08-11' do
      it { expect(TradingDayJp.open? Date.new(2016, 8, 11)).to equal false }
    end
  end
end
