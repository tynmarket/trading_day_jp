require "trading_day_jp/date"

module TradingDayJp

  class << self
    @@day_minus = [nil, 0, 1, 2, 3, 4, 5, 6]
    @@day_add = [nil, 0, 4, 3, 2, 1, 0, -1, -2]

    def open?(date)
      date.trading_day_jp?
    end

    def next(date)
      loop do
        date = date + 1

        return date if date.trading_day_jp?
      end
    end

    def prev(date)
      loop do
        date = date - 1

        return date if date.trading_day_jp?
      end
    end

    def between(start, last)
      (start..last).select do |date|
        date.trading_day_jp?
      end
    end

    def beginning_of_week(date)
      date = date - @@day_minus[date.cwday]
      cweek = date.cweek

      loop do
        if date.trading_day_jp?
          return date
        elsif date.cweek != cweek
          return
        end

        cweek = date.cweek
        date = date + 1
      end
    end

    def end_of_week(date)
      date = date + @@day_add[date.cwday]
      cweek = date.cweek

      loop do
        if date.trading_day_jp?
          return date
        elsif date.cweek != cweek
          return
        end

        cweek = date.cweek
        date = date - 1
      end
    end

    def beginning_of_month(date)
      date = Date.new(date.year, date.month)

      loop do
        return date if date.trading_day_jp?

        date = date + 1
      end
    end

    def end_of_month(date)
      date = Date.new(date.year, date.month).next_month - 1

      loop do
        return date if date.trading_day_jp?

        date = date - 1
      end
    end

    def beginning_of_month?(date)
      date == beginning_of_month(date)
    end

    def end_of_month?(date)
      date == end_of_month(date)
    end

    def beginning_of_quarter(date)
      if date.month <= 3
        beginning_of_month Date.new(date.year, 1)
      elsif date.month <= 6
        beginning_of_month Date.new(date.year, 4)
      elsif date.month <= 9
        beginning_of_month Date.new(date.year, 7)
      else
        beginning_of_month Date.new(date.year, 10)
      end
    end

    def end_of_quarter(date)
      if date.month <= 3
        end_of_month Date.new(date.year, 3)
      elsif date.month <= 6
        end_of_month Date.new(date.year, 6)
      elsif date.month <= 9
        end_of_month Date.new(date.year, 9)
      else
        end_of_month Date.new(date.year, 12)
      end
    end

    def beginning_of_quarter?(date)
      date == beginning_of_quarter(date)
    end

    def end_of_quarter?(date)
      date == end_of_quarter(date)
    end

    def beginning_of_year(date)
      self.next(Date.new date.year)
    end

    def end_of_year(date)
      prev beginning_of_year(Date.new(date.year + 1))
    end

    def beginning_of_year?(date)
      date == beginning_of_year(date)
    end

    def end_of_year?(date)
      date == end_of_year(date)
    end
  end

end
