# TradingDayJp

Trading days for Japanese stock market.

## Installation

Add this line to your application's Gemfile:

    gem 'trading_day_jp'
    gem "holiday_jp", github: "komagata/holiday_jp"


And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trading_day_jp

## Usage

日本の証券取引所で取引が行われる日であるか判定します。<br>
大発会〜大納会のうち、休日及び祝日でない日が該当します。

``` ruby
# 2014年12月30日は大納会
date = Date.new(2014, 12, 30)

date.trading_day_jp? # => true
TradingDayJp.open?(date) # => true

# 2014年12月31日は取引日でない
date = Date.new(2014, 12, 31)

date.trading_day_jp? # => false
TradingDayJp.open?(date) # => false

# 2014年9月23日は秋分の日
start = Date.new(2014, 9, 22)
last = Date.new(2014, 9, 26)

TradingDayJp.between(start, last)
  # => [<Date: 2014-09-22>, <Date: 2014-09-24>, <Date: 2014-09-25>, <Date: 2014-09-26>]

# 2014年6月2日はその月の最初の取引日
date = Date.new(2014, 6, 10)

TradingDayJp.beginning_of_month(date) # => <Date: 2014-06-02>

# 2014年8月29日はその月の最後の取引日
date = Date.new(2014, 8, 10)

TradingDayJp.end_of_month(date) # => <Date: 2014-08-29>

# 他にもメソッドあります
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/trading_day_jp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
