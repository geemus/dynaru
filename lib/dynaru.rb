require 'rubygems'
require 'json'

__DIR__ = File.dirname(__FILE__)

$LOAD_PATH.unshift __DIR__ unless
  $LOAD_PATH.include?(__DIR__) ||
  $LOAD_PATH.include?(File.expand_path(__DIR__))

require 'dynaru/server'

module Dynaru

  unless const_defined?(:VERSION)
    VERSION = '0.0.0'
  end

end
