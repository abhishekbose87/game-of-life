require 'minitest/autorun'
require_relative '../lib/grid'
require_relative '../lib/state'

class GridTest < Minitest::Test

  def test_accepts_input_from_a_file
    grid = Grid.new('data/4_by_4.txt')
    disp = grid.display
    assert_equal 4, disp.scan(/1/).count
  end

  def test_next
    grid = Grid.new('data/4_by_3.txt')
    disp = grid.display
    rows = disp.split("\n")
    assert_equal 4, rows.count
    assert_equal 3, rows.first.split(' ').count

    grid.next!
    disp = grid.display
    rows = disp.split("\n")
    assert_equal 5, rows.count
    assert_equal 4, rows.first.split(' ').count
    assert_equal 3, disp.scan(/1/).count
  end

end
