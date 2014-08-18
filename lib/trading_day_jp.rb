require "holiday_jp"

module TradingDayJp

  class ::Date

    def trading_day_jp?
      date_open = Date.new(self.year, 1, 4)
      date_close = Date.new(self.year, 12, 30)

      if saturday? || sunday?
        false
      elsif HolidayJp.holiday? self
        false
      elsif self < date_open || self > date_close
        false
      else
        true
      end
    end

  end

end
