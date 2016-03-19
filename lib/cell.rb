class Cell

  attr_reader :state, :row, :column, :alive_neighbours_count

  def initialize(row, col, state)
    @row        = row
    @column     = col
    @state = state
  end

  def dead?
    !state.alive?
  end

  def alive?
    state.alive?
  end

  def update_alive_neighbours_count(grid)
    @alive_neighbours_count = grid.alive_neighbours_count(self)
  end

  def toggled?
    state.alive? && state.becomes_dead?(alive_neighbours_count) ||
    state.dead? && state.becomes_alive?(alive_neighbours_count)
  end

  def toggle_state!
    @state = state.toggle
  end

  def value
    state.value
  end

end

class DeadCell < Cell
  def initialize
    @state = Cell::Dead.new
  end
end
