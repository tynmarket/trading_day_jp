require 'spec_helper'

describe Date do

  describe '#trading_day_jp?' do
    context '月曜日' do
      let(:date) { Date.new 2014, 8, 18 }

      it { expect(date.trading_day_jp?).to eq true }
    end

    context '金曜日' do
      let(:date) { Date.new 2014, 8, 22 }

      it { expect(date.trading_day_jp?).to eq true }
    end

    context '土曜日' do
      let(:date) { Date.new 2014, 8, 23 }

      it { expect(date.trading_day_jp?).to eq false }
    end

    context '日曜日' do
      let(:date) { Date.new 2014, 8, 24 }

      it { expect(date.trading_day_jp?).to eq false }
    end

    context '海の日（祝日）' do
      let(:date) { Date.new 2014, 7, 21 }

      it { expect(date.trading_day_jp?).to eq false }
    end

    context '大発会前日' do
      let(:date) { Date.new 2017, 1, 3 }

      it { expect(date.trading_day_jp?).to eq false }
    end

    context '大発会' do
      let(:date) { Date.new 2017, 1, 4 }

      it { expect(date.trading_day_jp?).to eq true }
    end

    context '大発会翌日' do
      let(:date) { Date.new 2017, 1, 5 }

      it { expect(date.trading_day_jp?).to eq true }
    end

    context '大発会（休日）' do
      let(:date) { Date.new 2014, 1, 4 }

      it { expect(date.trading_day_jp?).to eq false }
    end

    context '大納会前日' do
      let(:date) { Date.new 2014, 12, 29 }

      it { expect(date.trading_day_jp?).to eq true }
    end

    context '大納会' do
      let(:date) { Date.new 2014, 12, 30 }

      it { expect(date.trading_day_jp?).to eq true }
    end

    context '大納会翌日' do
      let(:date) { Date.new 2014, 12, 31 }

      it { expect(date.trading_day_jp?).to eq false }
    end

    context '大納会（休日）' do
      let(:date) { Date.new 2017, 12, 30 }

      it { expect(date.trading_day_jp?).to eq false }
    end
  end

end