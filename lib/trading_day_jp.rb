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

  def self.beginning_of_month(date)
    date = Date.new(date.year, date.month)

    loop do
      return date if date.trading_day_jp?

      date = date + 1
    end
  end

  def self.end_of_month(date)
    date = Date.new(date.year, date.month).next_month - 1

    loop do
      return date if date.trading_day_jp?

      date = date - 1
    end
  end

  def self.beginning_of_quarters(date)
    year = date.year

    [TradingDayJp.beginning_of_month(Date.new(year, 1)),
      TradingDayJp.beginning_of_month(Date.new(year, 4)),
      TradingDayJp.beginning_of_month(Date.new(year, 7)),
      TradingDayJp.beginning_of_month(Date.new(year, 10))]
  end

end
