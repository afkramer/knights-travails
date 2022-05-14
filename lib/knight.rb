# frozen_string_literal: true

require_relative './board'
require_relative './space'

# Basic functionality of the knight chess piece
class Knight
  attr_reader :moves_adjacency_list

  def initialize
    @board = Board.new
    @possible_moves = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]]
    @moves_adjacency_list = initialize_adjacency_list
  end

  def initialize_adjacency_list
    adjacency_list = []
    @board.spaces.each do |board_coords|
      space = Space.new(board_coords)
      @possible_moves.each do |move_coords|
        space.adjacent_coords << move(board_coords, move_coords) if allowable_move?(board_coords, move_coords)
        # necessary for search later?
        space.adjacent_coords.sort!
      end
      adjacency_list << space
    end
    adjacency_list
  end

  def allowable_move?(start_coords, move_coords)
    # Check if the final position is on the board
    @board.spaces.include?(move(start_coords, move_coords))
  end

  def move(start_coords, move_coords)
    [start_coords[0] + move_coords[0], start_coords[1] + move_coords[1]]
  end

  # Tried to update knight_moves_recur with min_required but it returns []
  # The moves_required list just keeps growing -> how to reset with relevant beginning moves?
  # Need to find a way to break out of the loops
  def knight_moves_recur_min(start_coords, end_coords, moves_required = [], min_required = [])
    return nil if moves_required.include?(start_coords)

    moves_required << start_coords
    space = @moves_adjacency_list[@board.spaces.index(start_coords)]
    if space.adjacent_coords.include?(end_coords)
      moves_required << end_coords
      min_required = moves_required if moves_required.length < min_required.length || min_required.empty?
      # will I need to reset the list here to [] or just previous moves?
      # The list of moves could potentially keep growing
    end

    space.adjacent_coords.each do |coords|

      knight_moves(coords, end_coords, moves_required, min_required)
    end
    min_required
  end

  # Works but returns the first path, not the shortest
  def knight_moves(start_coords, end_coords, prev_coords, moves_required = [])
    return nil if moves_required.include?(start_coords)

    moves_required << start_coords
    space = @moves_adjacency_list[@board.spaces.index(start_coords)]
    if space.adjacent_coords.include?(end_coords)
      moves_required << end_coords
      moves_required
    end

    space.adjacent_coords.each do |coords|
      #break if moves_required.include?(end_coords)

      knight_moves_recur(coords, end_coords, moves_required) if move_makes_sense?(coords, start_coords, prev_coords, end_coords)
    end
    moves_required
  end

  def move_makes_sense?(coords_to_test, start_coords, prev_coords, end_coords)
    return false if coords == prev_coords

    return false if too_close?(coords_to_test, end_coords)

    return true if both_coords_between?(coords_to_test, start_coords, end_coords)

    return true if coord_between_and_coord_within_bounds?(coords_to_test, start_coords, end_coords)
  end

  def too_close?(coords_to_test, end_coords)
    too_close_coords = [[-2, 2], [-2, -2], [2, -2], [2, 2], [0, 1], [-1, 0], [0, -1], [1, 0]]
    too_close_coords.each do |coords|
      return true if coords_to_test == [end_coords[0] + coords[0], end_coords[1] + coords[1]]
    end
    false
  end
end



knight = Knight.new
#p knight.knight_moves_recur([3, 3], [4, 3])

puts "Try [3, 4] and [4, 4]: #{knight.too_close?([3,4], [4, 4])}"
puts "Try [2,2] and [4,4]: #{knight.too_close?([2,2], [4, 4])}"
puts "Try [6,6] and [4,4]: #{knight.too_close?([6,6], [4, 4])}"
puts "Try [7,6] and [4,4]: #{knight.too_close?([7,6], [4, 4])}"
puts "Try [2,4] and [4,4]: #{knight.too_close?([2,4], [4, 4])}"
