require_relative "board"

class Piece
  attr_reader :color, :board
  attr_accessor :current_pos

  def initialize(color, initial_pos, board)
    @color = color
    @current_pos = initial_pos
    @board = board
  end

  def valid_movement?(start_pos, end_pos)
    return true
  end

end
