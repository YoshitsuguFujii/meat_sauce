# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'meat_sauce/version'

Gem::Specification.new do |spec|
  spec.name          = "meat_sauce"
  spec.version       = MeatSauce::VERSION
  spec.authors       = ["y.fujii"]
  spec.email         = ["ishikurasakura@gmail.com"]
  spec.description   = %q{ページをスクレイピングしたり、スクリーンショットを撮ったり(scraping web page, screen shot web page .... and more)}
  spec.summary       = %q{web util tool}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #spec.add_development_dependency "bundler", "~> 1.3"
  #spec.add_development_dependency "rake"
  spec.add_dependency('thor', '~> 0.17.0')
  spec.add_dependency('selenium-webdriver', '~> 2.35.1')
  spec.add_dependency('nokogiri', '~> 1.6.0')
  spec.add_dependency('anemone', '~> 0.7.2')
end
