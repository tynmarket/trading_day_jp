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

  describe '.between' do
    it '取引日でない日を含まない' do
      start = Date.new 2014, 9, 22
      last = Date.new 2014, 9, 26

      trading_days = TradingDayJp.between start, last

      expect(trading_days.size).to eq 4
      expect(trading_days[0]).to eq start
      expect(trading_days[1]).to eq Date.new(2014, 9, 24)
    end
  end

  describe '.beginning_of_month' do
    it 'その月の最初の取引日を取得する' do
      date = Date.new 2014, 6, 10

      expect(TradingDayJp.beginning_of_month date).to eq Date.new(2014, 6, 2)
    end
  end

  describe '.end_of_month' do
    it 'その月の最後の取引日を取得する' do
      date = Date.new 2014, 8, 10

      expect(TradingDayJp.end_of_month date).to eq Date.new(2014, 8, 29)
    end
  end

end
