#!/usr/bin/env ruby

require_relative 'lib/cell'
require_relative 'lib/grid'
require_relative 'lib/state'

class Gameoflife

  def initialize(inputfile)
    @delay        = 0
    @grid         = Grid.new(inputfile)
  end

  def run!
    50.times do
      puts @grid.display
      sleep @delay
      puts ""
      @grid.next!
    end
  end

end

puts Gameoflife.new(ARGV[0]).run!
