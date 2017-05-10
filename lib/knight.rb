require_relative 'piece'

class Knight < Piece
  include Steppers
  attr_reader :face

  def initialize(color, initial_pos, board)
    super
    @face = (color == :white ? "\u2658" : "\u265E")
  end

  def move_dirs
    Steppers::L_MOVEMENTS
  end

end
