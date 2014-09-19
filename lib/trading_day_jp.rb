require "trading_day_jp/date"

module TradingDayJp

  def self.open?(date)
    date.trading_day_jp?
  end

  def self.between(start, last)
    (start..last).select do |date|
      date.trading_day_jp?
    end
  end

end
