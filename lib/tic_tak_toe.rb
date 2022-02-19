# require "tic_tak_toe/version"

# module Game
  module Utils

    def coordinates_are_valid?(x, y)
      # valid_input = /[1-3]\s[1-3]/
      # valid_input.match(input) ? true : false
      x = x.to_i
      y = y.to_i
      x.between?(1,3) and y.between?(1,3) ? true : false
    end

    def spot_available?(x, y)
      #return boolean
      x = x.to_i
      y = y.to_i
      self.grid[x - 1][y - 1] ? false : true
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
      puts "#{self.current_player[:name]}, choose the x coordinate to place your piece. "      
      x = gets
      puts "#{self.current_player[:name]}, choose the y coordinate to place your piece. "
      y = gets
      input = "#{x}#{y}"

      return print_error("Please enter coordiantes between 1 and 3") unless coordinates_are_valid?(x, y)
      return print_error("The coordinates #{x} #{y} are already taken, please choose other coordinates.") unless spot_available?(x, y)

      self.update_board(x, y, self.current_player[:char])
    end

    def check_for_winner
      #algorithm to check board changes game_over state to true or false
      unless self.game_over == true
        #switch player
        #get index of current player
        idx_of_current_player = self.players.index(self.current_player)
        #ternary operator to switch players
        self.current_player = idx_of_current_player == 0 ? self.players[1] : self.players[0]
      else
        #game is over
        #move this to separate function?
        puts "Congrats #{self.current_player}, you are the winner."
        puts "Would you like to play another game? [Y/n]"
        play_again = gets

      end
    end

    def print_error(error_message)
      puts error_message
      self.get_input_and_update_board
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

    def update_board(x, y, char)
      x = x.to_i
      y = y.to_i
      self.grid[x - 1][y - 1] = char
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
  game.check_for_winner

end





#TODO 
#switch players
#get board to print to terminal in correct format

