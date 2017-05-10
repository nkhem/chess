require_relative 'piece'
require_relative 'sliders'

class Bishop < Piece
  include Sliders
  attr_reader :face

  def initialize(color, initial_pos, board)
    super
    @face = (color == :white ? "\u2657" : "\u265d")
  end

  def move_dirs
    Sliders::DIAGONALS
  end

end
