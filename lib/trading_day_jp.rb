require "trading_day_jp/date"

module TradingDayJp

  def self.open?(date)
    date.trading_day_jp?
  end

end
