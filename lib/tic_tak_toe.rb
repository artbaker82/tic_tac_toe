# require "tic_tak_toe/version"

# module Game
  module Utils

    def check_input(input)
      valid_input = /\d\s\d/
      valid_input.match(input)
    end

  end

  class Game
    attr_accessor :players, :current_player, :game_over

    include Utils

    def initialize
      @game_over = false
      @players = []
      @current_player
    end

    
    def add_player(player)
      players.push(player)
    end

    def get_input_and_update_board 
      print "#{self.current_player[:name]}, where do you choose to place your #{self.current_player[:char]}? "
      input = gets
      if check_input(input)
        self.update_board(input, self.current_player[:char])
      else
        puts 'Please enter two digits separated by a space'
        self.get_input
      end

    end


  end

  class Board < Game
    attr_accessor :grid

    def initialize
      super
      @grid = Array.new(3) { Array.new(3) }
    end

    def print_board 
      # self.grid.each {|i| print 'hello'}
      print self.grid
    end

    def update_board(coordinates, char)
      #coordinates are sanitizes to be two digits, separated by a space
      x = coordinates.split[0].to_i - 1
      y = coordinates.split[1].to_i - 1
      print "y #{y}"
      print "x #{x}"
      self.grid[x][y] = char
    end
  end

# end

game = Board.new

for a in 1..2 do 
  print "Enter name for player #{a} "
  player = gets
  char = a == 1 ? 'x' : 'o'
  game.add_player( {:name => player.chomp, :char => char} )
end

# while game is not over
#  get current user input
#  print board
#  check for winner
#  if no winner, switch player

game.current_player = game.players[0]

until game.game_over == true do
  game.get_input_and_update_board
  game.print_board
  # game.check_for_winner
end





#TODO 
# right now, inputs can be any number, in the check input method, make sure the input is
# two digits between 1 and 3.
# in the update_board method, make sure that subtracting by 1 will work.
# get board to print to terminal in correct format
