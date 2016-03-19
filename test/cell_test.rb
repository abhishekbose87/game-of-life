require 'minitest/autorun'
require_relative '../lib/cell'
require_relative '../lib/state'

class CellTest < Minitest::Test

  def test_alive?
    cell = Cell.new(1, 2, Cell::Alive.new)
    assert cell.alive?
  end

  def test_dies_with_less_than_2_live_neighbors
    cell = Cell.new(1, 2, Cell::Alive.new)
    cell.stub :alive_neighbours_count, 1 do
      assert cell.toggled?
    end
  end

  def test_dies_with_more_than_3_live_neighbors
    cell = Cell.new(1, 1, Cell::Alive.new)
    cell.stub :alive_neighbours_count, 4 do
      assert cell.toggled?
    end
  end

  def test_lives_if_2_neighbors_live
    cell = Cell.new(1, 1, Cell::Alive.new)
    cell.stub :alive_neighbours_count, 2 do
      refute cell.toggled?
    end
  end

  def test_lives_if_3_neighbors_live
    cell = Cell.new(1, 1, Cell::Alive.new)
    cell.stub :alive_neighbours_count, 3 do
      refute cell.toggled?
    end
  end

  def test_reanimates_with_3_live_neighbors
    cell = Cell.new(1, 1, Cell::Dead.new)
    cell.stub :alive_neighbours_count, 3 do
      assert cell.toggled?
    end
  end

end
