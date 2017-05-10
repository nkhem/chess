require_relative 'piece'

class Pawn < Piece
  attr_reader :face

  BLACK_DIAGONALS = [
    [1,-1],
    [1, 1]
    ]

  WHITE_DIAGONALS = [
    [-1, -1],
    [-1, 1]
    ]

  BLACK_VERTICALS = [
    [1, 0],
    [2, 0]
    ]

  WHITE_VERTICALS = [
    [-1, 0],
    [-2, 0]
    ]

  def initialize(color, initial_pos, board)
    super
    @face = (color == :white ? "\u2659" : "\u265f")
  end

  def valid_movement?(start_pos, end_pos)
    return true if move_options(board).include?(end_pos)
    false
  end

  def move_options(board)
    if self.color == :white
      verticals = WHITE_VERTICALS
      diagonals =  WHITE_DIAGONALS
    else
      verticals = BLACK_VERTICALS
      diagonals = BLACK_DIAGONALS
    end

    options = []
    verticals.each do |change|
      new_pos = add_diff(self.current_pos, change)
      options << new_pos if board.empty?(new_pos)
    end

    diagonals.each do |change|
      new_pos = add_diff(self.current_pos, change)
      options << new_pos if board[new_pos].color != self.color
    end
    options
  end

  def add_diff(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

end
