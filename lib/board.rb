# frozen_string_literal: true

# Essential elements of a chess board
class Board
  attr_reader :spaces

  def initialize
    @spaces = initialize_spaces
  end

  def initialize_spaces
    spaces_array = []
    (0..7).to_a.repeated_permutation(2) { |perm| spaces_array << perm }
    spaces_array
  end
end
