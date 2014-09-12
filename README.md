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
date = Date.new(2014, 12, 30)

date.trading_day_jp? # => true
TradingDayJp.open?(date) # => true

date = Date.new(2014, 12, 31)

date.trading_day_jp? # => false
TradingDayJp.open?(date) # => false
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/trading_day_jp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
