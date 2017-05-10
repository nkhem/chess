require_relative 'cursor'
require_relative 'piece'
require_relative 'null_piece'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'
require_relative 'graveyard'
require 'byebug'

class Board
  attr_reader :grid, :graveyard

  def initialize
    set_grid
    @graveyard = Graveyard.new
  end

  def set_grid
    col_indices = (0..7).to_a
    top_row = [
        Rook.new(:black, [0, col_indices.shift], self),
        Knight.new(:black, [0, col_indices.shift], self),
        Bishop.new(:black, [0, col_indices.shift], self),
        Queen.new(:black, [0, col_indices.shift], self),
        King.new(:black, [0, col_indices.shift], self),
        Bishop.new(:black, [0, col_indices.shift], self),
        Knight.new(:black, [0, col_indices.shift], self),
        Rook.new(:black, [0, col_indices.shift], self)
      ]

    col_indices = (0..7).to_a
    top_pawn_row = Array.new(1) do
      Array.new(8) do
        Pawn.new(:black, [1, col_indices.shift], self)
      end
    end

    mid_rows = Array.new(4) { Array.new(8) { NullPiece.new } }

    col_indices = (0..7).to_a
    bottom_pawn_row = Array.new(1) do
      Array.new(8) do
        Pawn.new(:white, [6, col_indices.shift], self)
      end
    end

    col_indices = (0..7).to_a
    bottom_row = [
        Rook.new(:white, [7, col_indices.shift], self),
        Knight.new(:white, [7, col_indices.shift], self),
        Bishop.new(:white, [7, col_indices.shift], self),
        Queen.new(:white, [7, col_indices.shift], self),
        King.new(:white, [7, col_indices.shift], self),
        Bishop.new(:white, [7, col_indices.shift], self),
        Knight.new(:white, [7, col_indices.shift], self),
        Rook.new(:white, [7, col_indices.shift], self)
      ]

    @grid = [top_row] +
      top_pawn_row +
      mid_rows +
      bottom_pawn_row +
      [bottom_row]
  end

  def remove_piece(dead_piece)
    if dead_piece.color == :white
      @graveyard.white_dead_pieces << dead_piece
    else
      @graveyard.black_dead_pieces << dead_piece
    end
  end

  def move_piece(start_pos, end_pos)
    if valid_move?(start_pos, end_pos)
      remove_piece(self[end_pos]) unless empty?(end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].current_pos = end_pos
      self[start_pos] = NullPiece.new
    end
  end

  def valid_move?(start_pos, end_pos)
    !empty?(start_pos) &&
      (empty?(end_pos) || different_colors?(start_pos, end_pos)) &&
      in_bounds([start_pos, end_pos]).length == 2 &&
      self[start_pos].valid_movement?(start_pos, end_pos)
  end

  def in_bounds(positions_array)
    positions_array.select { |position| in_bounds?(position) }
  end

  def in_bounds?(pos)
    row, col = pos
    (0..7).include?(row) && (0..7).include?(col)
  end

  def different_colors?(pos1, pos2)
    self[pos1].color != self[pos2].color
  end

  def empty?(pos)
    self[pos].is_a?(NullPiece)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,val)
    row, col = pos
    @grid[row][col] = val
  end

end
