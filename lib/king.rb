require_relative 'piece'
require_relative 'steppers'

class King < Piece
  include Steppers
  attr_reader :face

  def initialize(color, initial_pos, board)
    super
    @face = (color == :white ? "\u2654" : "\u265a")
  end

  def move_dirs
    Steppers::LATERALS + Steppers::DIAGONALS
  end

end
