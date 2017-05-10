require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game
  attr_reader :board, :player1, :player2, :displayer

  def initialize(player1, player2)
    @board = Board.new
    @player1 = HumanPlayer.new(player1)
    @player2 = HumanPlayer.new(player2)
    assign_colors
  end

  def assign_colors
    @player1.color = [:black, :white].sample
    @player2.color = (@player1.color == :white ? :black : :white)
  end

  def play
    display
    until game_over?
      @displayer.get_input(@board)
    end
    p "#{winner} wins!!"
  end

  def display
    @displayer = Display.new(@board)
    @displayer.render(board)
  end

  def game_over?
    white_lost? || black_lost?
  end

  def white_lost?
    @board.graveyard.white_dead_pieces.any?{|piece| piece.is_a?(King)}
  end

  def black_lost?
    @board.graveyard.black_dead_pieces.any?{|piece| piece.is_a?(King)}
  end

  def winner
    return "black" if white_lost?
    return "white" if black_lost?
  end

  # TODO
  # def check?
  # end
  #
  # def checkmate?
  # end
  #
  # def switch_players
  # end

end

if __FILE__ == $0
  game = Game.new("James", "Nicole")
  game.play
end
