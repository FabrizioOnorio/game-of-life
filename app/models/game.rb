class Game < ApplicationRecord
  # this method checks the cells around each cell of the matrix
  def active_neighbours_around_cell(x, y)
    @rows = self.matrix.size
    @columns = self.matrix[0].size
    active_neighbours = 0
    # top cell
    if y > 0
      active_neighbours += 1 if self.matrix[y - 1][x]
    end
    # top-right cell
    if y > 0 && x < (@columns -1)
      active_neighbours += 1 if self.matrix[y - 1][x + 1]
    end
    # right cell
    if x < (@columns - 1)
      active_neighbours += 1 if self.matrix[y][x + 1]
    end
    # bottom-right cell
    if y < (@rows - 1) && x < (@columns - 1)
      active_neighbours += 1 if self.matrix[y + 1][x + 1]
    end
    # bottom cell
    if y < (@rows - 1)
      active_neighbours += 1 if self.matrix[y + 1][x]
    end
    # bottom-left cell
    if y < (@rows - 1) && x > 0
      active_neighbours += 1 if self.matrix[y + 1][x - 1]
    end
    # left cell
    if x > 0
      active_neighbours += 1 if self.matrix[y][x - 1]
    end
    # top-left cell
    if y > 0 && x > 0
      active_neighbours += 1 if self.matrix[y - 1][x - 1]
    end
    active_neighbours
  end
end
