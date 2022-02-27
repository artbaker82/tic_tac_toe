# require "tic_tak_toe/version"

# module Game
  module Utils
    def coordinates_are_valid?(x, y)
      x = x.to_i
      y = y.to_i
      x.between?(1,3) and y.between?(1,3) ? true : false
    end

    def spot_available?(x, y)
      x = x.to_i
      y = y.to_i
      self.grid[x - 1][y - 1] ? false : true
    end
  end

  class Game
    attr_accessor :players, :current_player, :game_over, :playing

    include Utils

    def initialize
      @game_over = false
      @playing = true
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

      return print_error("Please enter coordinates between 1 and 3") unless coordinates_are_valid?(x, y)
      return print_error("The coordinates #{x} #{y} are already taken, please choose other coordinates.") unless spot_available?(x, y)

      self.update_board(x, y, self.current_player[:char])
    end

    def check_for_winner
      self.check_game_over
      unless self.game_over == true
        idx_of_current_player = self.players.index(self.current_player)
        self.current_player = idx_of_current_player == 0 ? self.players[1] : self.players[0]
      else
        #game is over
        #move this to separate function?
        puts "Congrats #{self.current_player[:name]}, you are the winner."
        puts "Would you like to play another game? [Y/n]"
        play_again = gets
        #reset board, get new players
        self.playing = play_again.chomp == 'Y' ? true : false
      end
    end

    def print_error(error_message)
      puts error_message
      self.get_input_and_update_board
    end

    def reset
      self.grid = Array.new(3) { Array.new(3) }
      self.game_over = false
    end

    def check_game_over
      #possible winning combinations
      winning_board_possibilities = [
        #across
        [[0,0],[0,1],[0,2]],
        [[1,0],[1,1],[1,2]],
        [[2,0],[2,1],[2,2]],
        #down
        [[0,0],[1,0],[2,0]],
        [[0,1],[1,1],[2,1]],
        [[0,2],[1,2],[2,2]],
        #diagonal
        [[0,0],[1,1],[2,2]],
        [[0,2],[1,1],[2,0]] 
      ]

        #loop through all possibilities, if all coordinates evaluate to a single piece, then that player is the winner
        current_piece = self.current_player[:char].to_s

        self.game_over = winning_board_possibilities.any? do | winning_board | 
          winning_board.all? { | coordinate| self.grid[coordinate[0]][coordinate[1]] == current_piece }
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
      # print self.grid
      self.grid.each_with_index do | row, idx |
        col1, col2, col3 = row.map { | item | item ? item : " " }
        puts "#{col1}|#{col2}|#{col3}"
      end

    end

    def update_board(x, y, char)
      x = x.to_i
      y = y.to_i
      self.grid[x - 1][y - 1] = char
    end
  end

game = Board.new

for a in 1..2 do 
  print "Enter name for player #{a} "
  player = gets
  char = a == 1 ? 'x' : 'o'
  game.add_player( {:name => player.chomp, :char => char} )
end


while game.playing == true do 
  game.reset
  game.current_player = game.players[0]

  until game.game_over == true do
    game.get_input_and_update_board
    game.print_board
    game.check_for_winner

  end

end

puts 'Thank you for playing, press ctlr c to exit'



#ideas to continue
#save game history,
#simple AI to play against 
