require "trading_day_jp/date"

module TradingDayJp

  def self.open?(date)
    date.trading_day_jp?
  end

  def self.next(date)
    loop do
      date = date + 1

      return date if date.trading_day_jp?
    end
  end

  def self.prev(date)
    loop do
      date = date - 1

      return date if date.trading_day_jp?
    end
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

  def self.beginning_of_month?(date)
    date == beginning_of_month(date)
  end

  def self.end_of_month?(date)
    date == end_of_month(date)
  end

  def self.beginning_of_quarter(date)
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

  def self.end_of_quarter(date)
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

  def self.beginning_of_quarter?(date)
    date == beginning_of_quarter(date)
  end

  def self.end_of_quarter?(date)
    date == end_of_quarter(date)
  end

  def self.beginning_of_year(date)
    self.next(Date.new date.year)
  end

  def self.end_of_year(date)
    prev beginning_of_year(Date.new(date.year + 1))
  end

  def self.beginning_of_year?(date)
    date == beginning_of_year(date)
  end

  def self.end_of_year?(date)
    date == end_of_year(date)
  end

  def self.beginning_of_quarters(date)
    year = date.year

    [ beginning_of_month(Date.new(year, 1)),
      beginning_of_month(Date.new(year, 4)),
      beginning_of_month(Date.new(year, 7)),
      beginning_of_month(Date.new(year, 10)) ]
  end

  def self.beginning_of_quarters?(date)
    beginning_of_quarters(date).include?(date)
  end

end
