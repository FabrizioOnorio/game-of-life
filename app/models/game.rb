class Game < ApplicationRecord
  attr_accessor :matrix, :columns, :rows

  def initialize(values)
    @columns = values[:columns]
    @rows = values[:rows]
    @matrix = load_matrix
    super
  end

  def load(cells)
    cells.each { |y, x| matrix[y][x] = 1 }
  end

  def neighbors_count(y, x)
    neighbors(y, x).count { |cell| cell == 1 }
  end

  def execute
    new_matrix = load_matrix
    matrix.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        count = neighbors_count(y, x)
        new_matrix[y][x] = begin
          if cell.zero?
            [3].include?(count) ? 1 : 0
          else
            [2, 3].include?(count) ? 1 : 0
          end
        end
      end
    end

    @matrix = new_matrix
  end


  private

  def neighbors(y, x)
    (-1..1).inject [] do |values, py|
      (-1..1).each do |px|
        unless py == 0 and px == 0
          i = y + py
          j = x + px
          i = 0 unless i < rows
          j = 0 unless j < columns
          values << matrix[i][j]
        end
      end
      values
    end
  end

  def load_matrix
    Array.new(rows) { Array.new(columns, 0) }
  end
end
