class GamesController < ApplicationController
  before_action :default_matrix, only: [:index, :start, :clear]

  def index
    @game = Game.new({ columns: @columns, rows: @rows })
  end

  def start
    cells = []
    if params[:load] == 'true'
      params[:cells].to_hash.values.each do |columns, row|
        cells.push([columns.to_i, row.to_i])
      end
      @game.load cells
    end
    @matrix = @game.execute
  end

  def clear
    @game = Game.new(@columns, @rows)
  end

  private

  def default_matrix
    @rows = 8
    @columns = 10
  end
end
