require 'byebug'

module Sliders
  DIAGONALS = [
    [1,1],
    [-1, 1],
    [-1,-1],
    [1, -1]
  ]
  LATERALS = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ]

  def valid_movement?(start_pos, end_pos)
    return true if move_options(board).include?(end_pos)
    false
  end

  def move_options(board)
    options = []
    move_dirs.each do |change|
      new_pos = add_diff(self.current_pos, change)
      dead_end = false
      until dead_end
        if !board.in_bounds?(new_pos)
          dead_end = true
        elsif board.empty?(new_pos)
          options << new_pos
          new_pos = add_diff(new_pos, change)
        elsif board[new_pos].color != self.color
          options << new_pos
          dead_end = true
        elsif board[new_pos].color == self.color
          dead_end = true
        end
      end

    end

    options
  end

  def add_diff(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

end
