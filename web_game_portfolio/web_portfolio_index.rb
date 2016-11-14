require 'sinatra'
require './mastermind.rb'
require './tictactoe.rb'

class WebPortfolio<Sinatra::Base
    @@mastermind = MasterMind.new
    @@count = 0
    @@tictactoe = TicTacToe.new
	@@tictactoe_count = 1
    enable :sessions
    
    get '/' do
    	@message = "Welcome to Jake's Game Imporium"
    	erb :index
    end
    
    post '/mastermind' do
        puts params.inspect
        @colors = @@mastermind.colors
        if params['reset']
    		@message = "Game Reset!"
    		@@count = 0
    		session.clear
    		session['count'] = 0
    		@@mastermind.reset
    		erb :mastermind_game
    	elsif params['mastermind']
    	    @message = "Welcome to mastermind!"
    		@@count = 0
    		session['count'] = 0
    		erb :mastermind_game
    	else
	    	@colors = @@mastermind.colors
	    	@@mastermind.guess = [params['guess1'], params['guess2'], params['guess3'], params['guess4']].to_a
			@@mastermind.get_human_guess
			@message = @@mastermind.valid
			@exit = params['exit']
			if @@mastermind.is_valid
				@@count += 1 
				@guess = @@mastermind.guess
				@@mastermind.check
				@black = @@mastermind.black
				@white = @@mastermind.white
				session['count'] = @@count
				session[@@count] = @guess 
				session[@guess] = [@black, @white]
				if @@mastermind.victory
					@message = "You Won"
				else
					@message = "You Lost" if @@count == 12
				end
			elsif @exit == 'exit'
				@message = "See you again!"
			else
				@message = "There was an error!"
			end
			erb :mastermind_game
	    end
    end
    
    post '/tictactoe' do
    	@board = @@tictactoe.display.board
    	@spaces = [:one, :two, :three, :four, :five, :six, :seven, :eight, :nine].to_a
    	if params['tictactoe']
    		@message = "Welcome to TicTacToe"
        	erb :tictactoe_game
    	elsif params['reset']
    		@message = @@tictactoe.reset_game
    		@board = @@tictactoe.display.board
    		erb :tictactoe_game
    	else
    		@move = params.keys[0]
	    	if @@tictactoe.valid(params[@move])
	    		@@tictactoe_count += 1
    			@count = @@tictactoe_count % 2
	    		@@tictactoe.display.update(params[@move], @move.to_sym)
	    		@message = "Nice Move!"
			else
				@message = "That's not a valid input!"
			end
			@message = "Tie!" if @@tictactoe.check_for_tie
			@message = "Yeah! You won!" if @@tictactoe.check_for_victory(params[@move])
			erb :tictactoe_game
		end
    end
    
    post '/home' do
        @message = "Welcome to Jake's Game Imporium"
    	erb :index
    end
    
end