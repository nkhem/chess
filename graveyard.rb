require_relative 'piece'
require_relative 'null_piece'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'

class Graveyard
  attr_accessor :black_dead_pieces, :white_dead_pieces

  def initialize
    @black_dead_pieces = []
    @white_dead_pieces = []
  end

  def display_black
    result = ""
    @black_dead_pieces.each do |piece|
      result << piece.face + " "
    end
    result
  end

  def display_white
    result = ""
    @white_dead_pieces.each do |piece|
      result << piece.face + " "
    end
    result
  end

end
