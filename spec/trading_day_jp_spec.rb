require 'spec_helper'

describe TradingDayJp do

  describe '.open?' do
    it { expect(TradingDayJp.open? Date.new(2014, 8, 28)).to eq true }
  end

end