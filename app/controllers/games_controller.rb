class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    file = params[:game][:import_file]
    error_message = validation(file)
    if error_message
      flash.now.alert = error_message
      @game = Game.new
      render :new
    else
      matrix = parse_matrix(file)
      generation = parse_generation(file)
      @game = Game.new({ matrix: matrix, generation: generation })
      if @game.save
        redirect_to game_path(@game)
      else
        render :new
      end
    end
  end

  def update
    @game = Game.find(params[:id])
    old_generation = @game
    old_game_save = Marshal.load( Marshal.dump(old_generation) )
    tick
    @game.save
    new_generation = @game
    if old_game_save.matrix != new_generation.matrix
      new_generation.generation = old_game_save.generation += 1
    else
      flash.alert = ">The game is over <"
    end
    @game.save
    redirect_to game_path(@game.id)
  end

  private

  def parse_matrix(file)
    file = File.read(file).split(/\n/)
    matrix_size = file[1].split(' ')
    @rows = matrix_size[0].to_i
    @columns = matrix_size[1].to_i
    file[2..].map { |row| row.split('').map { |element| element == '.' ? false : true} }
  end

  def parse_generation(file)
    file = File.read(file).split(/\n/)
    file[0].scan(/\d/).join('').to_i
  end

  def validation(file)
    return "Please make sure you are uploading a txt file" unless file_validation_extention(file)
    return "Make sure the second line containes 2 numbers separated by one space ex. '4 6'" unless validation_matrix_size(file)
    return "Please make sure that all the rows have the right length" unless validation_rows_legth(file)
    return "Plese make sure you have the right ammount of rows" unless validation_number_of_rows(file)
    return "In your rows you can only use '.' for dead cells and '*' for active cells" unless validation_element(file)
    return "The first line must include the word Generate followed by a space, then a number and a column ex. 'Generation 34:" unless validation_matrix_first_statement(file)
  end

  def file_validation_extention(file)
    File.extname(file) == '.txt'
  end

  def validation_rows_legth(file)
    file = File.read(file).split(/\n/)
    matrix_size = file[1].split(' ')
    rows_length = matrix_size[1].to_i
    check = file[2..].map do |row|
      row.size == rows_length
    end
    !check.include?(false)
  end

  def validation_number_of_rows(file)
    file = File.read(file).split(/\n/)
    matrix_size = file[1].split(' ')
    rows_number = matrix_size[0].to_i
    file[2..].count == rows_number
  end

  def validation_element(file)
    file = File.read(file).split(/\n/)
    check = file[2..].map do |row|
      new_string = row.gsub('.', '').gsub('*', '')
      new_string.length.zero?
    end
    !check.include?(false)
  end

  def validation_matrix_size(file)
    file = File.read(file).split(/\n/)
    pattern = /\d+ \d+/
    pattern.match?(file[1])
  end

  def validation_matrix_first_statement(file)
    file = File.read(file).split(/\n/)
    pattern = /Generation \d+:/
    pattern.match?(file[0])
  end

  def tick
    @next_round_active_cells = []
    @next_round_dead_cells = []
    @game.matrix.each_with_index do |row, y|
      row.each_with_index do |_cell, x|
        check_cell(x, y)
      end
    end
    @next_round_active_cells.each { |cell| @game.matrix[cell[1]][cell[0]] = true }
    @next_round_dead_cells.each { |cell| @game.matrix[cell[1]][cell[0]] = false }
  end

  def check_cell(x, y)
    neighbour_count = @game.active_neighbours_around_cell(x, y)
    # Any live cell with fewer than two or greater then 3 live neighbours dies
    @next_round_dead_cells << [x, y] if @game.matrix[y][x] && (neighbour_count < 2 || neighbour_count > 3)
    # Any live cell with two or three live neighbours lives on to the next generation
    @next_round_active_cells << [x, y] if @game.matrix[y][x] && ([2, 3].include? neighbour_count)
    # Any dead cell with exactly three live neighbours becomes a live cell
    @next_round_active_cells << [x, y] if !@game.matrix[y][x] && neighbour_count == 3
  end
end
