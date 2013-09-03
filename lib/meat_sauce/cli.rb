# encoding: utf-8
require "thor"

module MeatSauce
  class CLI < Thor
    desc list, 'list something'
    def list
      puts "write something to ist"
    end
  end
end
