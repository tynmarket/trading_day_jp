# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trading_day_jp/version'

Gem::Specification.new do |spec|
  spec.name          = "trading_day_jp"
  spec.version       = TradingDayJp::VERSION
  spec.authors       = ["Takehiko Shinkura"]
  spec.email         = ["tynmarket@gmail.com"]
  spec.summary       = %q{Trading days for Japanese stock market}
#  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/tyn-iMarket/trading_day_jp.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"

  spec.add_dependency "holiday_jp", ">= 0.7"
end