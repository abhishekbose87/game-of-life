require_relative 'cell'
require_relative 'state'

class Grid

  ALIVE = '1'
  DEAD = '0'
  RANDOM_DEAD_CELL = DeadCell.new

  attr_reader :grid

  def initialize(file_name)
    raise "No file with name: #{file_name}" unless File.exist? file_name
    file     = File.read(file_name).split("\n")
    @rows    = file.count - 1
    @columns = file.first.split(' ').count - 1

    @row_low     = 0
    @columns_low = 0

    @grid    = build_from file
  end

  def display
    output_grid = []
    (@row_low..@rows).each do |r_idx|
      o_row = []
      (@columns_low..@columns).each do |c_idx|
        cell = cell_at(r_idx, c_idx) || RANDOM_DEAD_CELL
        o_row << cell.value
      end
      output_grid << o_row
    end

    [].tap { |output|
      output << output_grid.map{|row| row.map{|cell| cell }.join(" ")}
    }.join("\n")
  end

  def next!
    expand_if_reqd
    update_alive_neighbours_count

    cells_whose_state_will_remain_same = grid.select { |cell| !cell.toggled? }

    cells_whose_state_will_be_toggled = grid.select { |cell| cell.toggled? }
    cells_whose_state_will_be_toggled.map &:toggle_state!

    @grid = cells_whose_state_will_remain_same + cells_whose_state_will_be_toggled
    @grid.reject! { |cell| cell.dead? }
  end

  def alive_neighbours_count(cell)
    row             = cell.row
    column          = cell.column

    neighbours = []

    neighbours.push(cell_at(row - 1, column - 1))
    neighbours.push(cell_at(row - 1, column))
    neighbours.push(cell_at(row - 1, column + 1))
    neighbours.push(cell_at(row, column - 1))
    neighbours.push(cell_at(row, column + 1))
    neighbours.push(cell_at(row + 1, column - 1))
    neighbours.push(cell_at(row + 1, column))
    neighbours.push(cell_at(row + 1, column + 1))

    neighbours.select{|n| n && n.alive?}.size
  end


  private

  def update_alive_neighbours_count
    grid.each { |cell| cell.update_alive_neighbours_count(self) }
  end

  def expand_if_reqd
    grid.select { |cell| cell.alive? }.each { |cell| create_neighbours_if_reqd(cell) }
  end

  def create_neighbours_if_reqd(cell)
    row             = cell.row
    column          = cell.column

    find_or_create_cell(row - 1, column - 1)
    find_or_create_cell(row - 1, column)
    find_or_create_cell(row - 1, column + 1)
    find_or_create_cell(row, column - 1)
    find_or_create_cell(row, column + 1)
    find_or_create_cell(row + 1, column - 1)
    find_or_create_cell(row + 1, column)
    find_or_create_cell(row + 1, column + 1)
  end

  def build_from(file)
    grid = []

    file.each_with_index do |row, r_idx|
      row.split(' ').each_with_index do |state, c_idx|
        alive?(state) && grid << Cell.new(r_idx, c_idx, Cell::Alive.new)
      end
    end
    grid
  end

  def alive?(state)
    state == ALIVE
  end

  def create_cell(x, y)
    cell = Cell.new(x, y, Cell::Dead.new)
    @grid << cell
    expand_grid(x, y)
    cell
  end

  def find_or_create_cell(x, y)
    find_cell(x,y) || create_cell(x, y)
  end

  def cell_at(x, y)
    find_cell(x,y)
  end

  def find_cell(x, y)
    grid.select {|c| c.row == x && c.column == y}.first
  end

  def expand_grid(x, y)
    @row_low     = [x, @row_low].min
    @rows        = [x, @rows].max
    @columns_low = [y, @columns_low].min
    @columns     = [y, @columns].max
  end

end
