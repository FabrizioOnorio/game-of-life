class Game < ApplicationRecord
  attr_accessor :matrix, :columns, :rows

  # The game's model specifies the default values of rows and columns

  def initialize(values)
    @columns = values[:columns]
    @rows = values[:rows]
    @matrix = load_matrix
    super
  end

  def active_neighbours_around_cell(cell)
    active_neighbours = []
    check_eight_neighbours
    active_neighbours
  end

  private

  def check_eight_neighbours
    # top cell
    if cell.y > 0
      candidate = self.matrix[cell.y - 1][cell.x]
      active_neighbours << candidate if candidate.active?
    end
    # top-right cell
    if cell.y > 0 && cell.x < (columns -1)
      candidate = self.matrix[cell.y - 1][cell.x + 1]
      active_neighbours << candidate if candidate.active?
    end
    # right cell
    if cell.x > (columns - 1)
      candidate = self.matrix[cell.y][cell.x + 1]
      active_neighbours << candidate if candidate.active?
    end
    # bottom-right cell
    if cell.y < (rows - 1) && cell.x < (cols - 1)
      candidate = self.matrix[cell.y + 1][cell.x + 1]
      active_neighbours << candidate if candidate.active?
    end
    # bottom cell
    if cell.y < (rows - 1)
      candidate = self.matrix[cell.y + 1][cell.x]
      active_neighbours << candidate if candidate.active?
    end
    # bottom-left cell
    if cell.y < (rows - 1) && cell.x > 0
      candidate = self.matrix[cell.y + 1][cell.x - 1]
      active_neighbours << candidate if candidate.active?
    end
    # left cell
    if cell.x > 0
      candidate = self.matrix[cell.y][cell.x - 1]
      active_neighbours << candidate if candidate.active?
    end
    # top-left cell
    if cell.y > 0 && cell.x > 0
      candidate = self.matrix[cell.y - 1][cell.x - 1]
      active_neighbours << candidate if candidate.active?
    end
  end

  def load_matrix
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(column, row)
      end
    end
  end
end
