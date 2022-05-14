# frozen_string_literal: true

require_relative './board'
require_relative './space'
require_relative './knight'

def main
  knight = Knight.new
  puts
  puts "Welcome to Knight's Travails!"
  puts
  puts 'This little program will tell you the shortest path'
  puts 'a chess knight can travel between two spaces.'
  puts
  puts 'Just supply the starting and ending coordinates.'
  puts
  print 'Would you like to supply coordinates? y/n: '
  continue = gets.chomp
  while continue.downcase == 'y'
    puts
    print 'Please enter the starting coordinates (format: x, y): '
    starting = gets.chomp.split(",").map! { |num| num.to_i }
    puts
    print 'Please enter the ending coordinates (format: x, y): '
    ending = gets.chomp.split(",").map! { |num| num.to_i }
    puts
    puts "The shortest path is: #{knight.knight_moves(starting, ending)}"
    puts
    print 'Would you like to provide more coordinates? y/n: '
    continue = gets.chomp
  end
  puts
  puts "Thanks for trying out Knight's Travails!"
  puts
end

main
