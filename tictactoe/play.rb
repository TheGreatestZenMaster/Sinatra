require 'sinatra'
require './tictactoe.rb'

class TicTacToe<Sinatra::Base
    @@game = Game.new
	@@count = 1
	@@spaces = [:one, :two, :three, :four, :five, :six, :seven, :eight, :nine].to_a
	
    get '/' do
    	@message = "When you're ready!"
    	@board = @@game.display.board
    	@spaces = @@spaces
        erb :index
    end
    post '/tictactoe' do
    	@spaces = @@spaces
    	@@count += 1
    	@count = @@count % 2
    	@board = @@game.display.board
    	if params['reset']
    		@message = @@game.reset_game
    		@board = @@game.display.board
    		erb :index
    	else
    		@move = params.keys[0]
	    	if @@game.valid(params[@move])
	    		@@game.display.update(params[@move], @move.to_sym)
	    		@message = "Nice Move!"
			else
				@message = "That's not a valid input!"
			end
			@message = "Tie!" if @@game.check_for_tie
			@message = "Yeah! You won!" if @@game.check_for_victory(params[@move])
			erb :index
		end
    end
end
