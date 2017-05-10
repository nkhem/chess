require_relative 'board'
require 'colorize'
require_relative 'cursor'
require 'byebug'

class Display
  attr_reader :cursor, :i

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @i = 0
  end

  def render(board)
    system("clear")
    result = [board.graveyard.display_white, ""]
    row_result = ""
    board.grid.each_with_index do |row, row_index|
      row_result = render_row(row, row_index, board)
      result << row_result
      @i = (@i == 0 ? 1 : 0)
      end

    result << [
      "",
      board.graveyard.display_black,
      "",
      "",
      ""
    ]
    puts result
  end

  def render_row(row, row_index, board)
    row_result = ""

    if @cursor.selected_start && @cursor.selected_end
      board.move_piece(@cursor.selected_start, @cursor.selected_end)
      @cursor.selected_start, @cursor.selected_end = nil, nil
    end

    row.each_with_index do |piece, col_index|
      current_pos = [row_index, col_index]

      if current_pos == @cursor.selected_start && !board.empty?(current_pos)
        string = piece.face.yellow
      elsif current_pos == @cursor.cursor_pos
        string = (board.empty?(current_pos) ? "\u2022".red : piece.face.red)
      else
        string = piece.face
      end

      string = " #{string} "

      row_result += colored(string)
    end
    row_result
  end

  def colored(string)
    if i == 0
      @i = 1
      string.colorize(:background => :grey)
    else
      @i = 0
      string.colorize( :background => :white)
    end
  end

  def get_input(board)
    @cursor.get_input
    self.render(board)
  end

end
