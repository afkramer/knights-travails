#frozen_string_literal: true

require_relative './board'

# Basic functionality of the knight chess piece
class Knight
  def initialize
    @board = Board.new
    @possible_moves = initialize_moves
  end

  def initialize_moves
    # Create a graph of all possible moves a knight has on the board
  end
end
