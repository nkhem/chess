require_relative 'piece'

class Rook < Piece
  include Sliders
  attr_reader :face

  def initialize(color, initial_pos, board)
    super
    @face = (color == :white ? "\u2656" : "\u265c")
  end

  def move_dirs
    Sliders::LATERALS
  end

end
