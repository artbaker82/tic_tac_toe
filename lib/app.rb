$LOAD_PATH << '.'
require 'tic_tak_toe.rb'

game = Game::Board.new

# for a in 1..2 do 
#   print "Enter name for player #{a}"
#   player = gets
#   game.add_player(player.chomp)
# end

print game.game_over

