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

  describe '.beginning_of_week' do
    it 'その週の最初の取引日を取得する' do
      date = Date.new 2015, 5, 8

      expect(TradingDayJp.beginning_of_week date).to eq Date.new(2015, 5, 7)
    end

    context '月曜' do
      let(:date) { Date.new 2014, 2, 3 }

      it { expect(TradingDayJp.beginning_of_week date).to eq date }
    end

    context 'その週は取引日がない' do
      it 'returns nil' do
        allow_any_instance_of(Date).to receive(:trading_day_jp?) { false }

        date = Date.new 2014, 2, 3

        expect(TradingDayJp.beginning_of_week date).to be_nil
      end
    end
  end

  describe '.end_of_week' do
    it 'その週の最後の取引日を取得する' do
      date = Date.new 2014, 3, 19

      expect(TradingDayJp.end_of_week date).to eq Date.new(2014, 3, 20)
    end

    context '日曜' do
      it do
        date  = Date.new 2014, 2, 23

        expect(TradingDayJp.end_of_week date).to eq Date.new(2014, 2, 21)
      end
    end

    context 'その週は取引日がない' do
      it 'returns nil' do
        allow_any_instance_of(Date).to receive(:trading_day_jp?) { false }

        date = Date.new 2014, 2, 3

        expect(TradingDayJp.end_of_week date).to be_nil
      end
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

  describe '.beginning_of_month?' do
    it do
      date = Date.new 2014, 6, 2

      expect(TradingDayJp.beginning_of_month? date).to eq true
    end
  end

  describe '.end_of_month?' do
    it do
      date = Date.new 2014, 8, 29

      expect(TradingDayJp.end_of_month? date).to eq true
    end
  end

  describe '.beginning_of_quarter' do
    context '3月' do
      it do
        date = Date.new 2014, 3, 1

        expect(TradingDayJp.beginning_of_quarter date).to eq Date.new(2014, 1, 6)
      end
    end

    context '6月' do
      it do
        date = Date.new 2014, 6, 1

        expect(TradingDayJp.beginning_of_quarter date).to eq Date.new(2014, 4, 1)
      end
    end

    context '9月' do
      it do
        date = Date.new 2014, 9, 1

        expect(TradingDayJp.beginning_of_quarter date).to eq Date.new(2014, 7, 1)
      end
    end

    context '12月' do
      it do
        date = Date.new 2014, 12, 1

        expect(TradingDayJp.beginning_of_quarter date).to eq Date.new(2014, 10, 1)
      end
    end
  end

  describe '.end_of_quarter' do
    context '1月' do
      it do
        date = Date.new 2014, 1, 1

        expect(TradingDayJp.end_of_quarter date).to eq Date.new(2014, 3, 31)
      end
    end

    context '4月' do
      it do
        date = Date.new 2014, 4, 1

        expect(TradingDayJp.end_of_quarter date).to eq Date.new(2014, 6, 30)
      end
    end

    context '7月' do
      it do
        date = Date.new 2014, 7, 1

        expect(TradingDayJp.end_of_quarter date).to eq Date.new(2014, 9, 30)
      end
    end

    context '10月' do
      it do
        date = Date.new 2014, 10, 1

        expect(TradingDayJp.end_of_quarter date).to eq Date.new(2014, 12, 30)
      end
    end
  end

  describe '.beginning_of_quarter?' do
    it do
      date = Date.new 2014, 4, 1

      expect(TradingDayJp.beginning_of_quarter? date).to eq true
    end
  end

  describe '.end_of_quarter?' do
    it do
      date = Date.new 2014, 3, 31

      expect(TradingDayJp.end_of_quarter? date).to eq true
    end
  end

  describe '.beginning_of_year' do
    it 'その年の最初の取引日を取得する' do
      date = Date.new 2014, 6, 10

      expect(TradingDayJp.beginning_of_year date).to eq Date.new(2014, 1, 6)
    end
  end

  describe '.end_of_year' do
    it 'その年の最後の取引日を取得する' do
      date = Date.new 2014, 6, 10

      expect(TradingDayJp.end_of_year date).to eq Date.new(2014, 12, 30)
    end
  end

  describe '.beginning_of_year?' do
    it do
      date = Date.new 2014, 1, 6

      expect(TradingDayJp.beginning_of_year? date).to eq true
    end
  end

  describe '.end_of_year?' do
    it do
      date = Date.new 2014, 12, 30

      expect(TradingDayJp.end_of_year? date).to eq true
    end
  end

end
