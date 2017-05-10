require_relative 'piece'

class Queen < Piece
  include Sliders
  attr_reader :face

  def initialize(color, initial_pos, board)
    super
    @face = (color == :white ? "\u2655" : "\u265b")
  end

  def move_dirs
    Sliders::LATERALS + Sliders::DIAGONALS
  end

end
