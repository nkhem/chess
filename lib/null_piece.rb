require_relative 'piece'

class NullPiece < Piece
  attr_reader :color, :face

  def initialize
    @color = nil
    @face = " "
  end

end
