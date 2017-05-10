module Steppers
  L_MOVEMENTS = [
    [2, 1],
    [1, 2],

    [2, -1],
    [1, -2],

    [-2, -1],
    [-1, -2],

    [2, -1],
    [1, -2]
  ]

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
    options = move_dirs.map do |change|
      add_diff(self.current_pos, change)
    end

    options.reject do |new_pos|
      board[new_pos].color == self.color
    end
  end

  def add_diff(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end
end
