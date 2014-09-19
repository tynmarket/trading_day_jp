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

  describe '.next' do
    it '次の取引日を取得する' do
      date = Date.new 2014, 2, 10
      next_date = date + 1
      next_trading_day = TradingDayJp.next date

      expect(next_date.trading_day_jp?).to eq false
      expect(next_trading_day.trading_day_jp?).to eq true
      expect(next_trading_day).to eq Date.new(2014, 2, 12)
    end
  end

  describe '.prev' do
    it '前の取引日を取得する' do
      date = Date.new 2014, 2, 12
      prev_date = date - 1
      prev_trading_day = TradingDayJp.prev date

      expect(prev_date.trading_day_jp?).to eq false
      expect(prev_trading_day.trading_day_jp?).to eq true
      expect(prev_trading_day).to eq Date.new(2014, 2, 10)
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

    context '月初' do
      it do
        date = Date.new 2014, 5, 1

        expect(TradingDayJp.beginning_of_month date).to eq date
      end
    end
  end

  describe '.end_of_month' do
    it 'その月の最後の取引日を取得する' do
      date = Date.new 2014, 8, 10

      expect(TradingDayJp.end_of_month date).to eq Date.new(2014, 8, 29)
    end

    context '月末' do
      it do
        date = Date.new 2014, 6, 30

        expect(TradingDayJp.end_of_month date).to eq date
      end
    end
  end

  describe '.beginning_of_quarters' do
    it 'その年の各四半期の最初の取引日を取得する' do
      date = Date.new 2014, 5, 1

      trading_days = TradingDayJp.beginning_of_quarters date

      expect(trading_days.size).to eq 4
      expect(trading_days[0]).to eq Date.new(2014, 1, 6)
      expect(trading_days[1]).to eq Date.new(2014, 4, 1)
      expect(trading_days[2]).to eq Date.new(2014, 7, 1)
      expect(trading_days[3]).to eq Date.new(2014, 10, 1)
    end
  end

  describe '.beginning_of_quarters?' do
    let(:beginning_of_quarters) { TradingDayJp.beginning_of_quarters? date }

    context '2014/01/06' do
      let(:date) { Date.new 2014, 1, 6 }

      it { expect(beginning_of_quarters).to eq true }
    end

    context '2014/04/01' do
      let(:date) { Date.new 2014, 4, 1 }

      it { expect(beginning_of_quarters).to eq true }
    end

    context '2014/05/01' do
      let(:date) { Date.new 2014, 5, 1 }

      it { expect(beginning_of_quarters).to eq false }
    end
  end

end
