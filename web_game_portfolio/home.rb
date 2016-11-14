require 'sinatra'
require './mastermind.rb'

class WebPortfolio<Sinatra::Base
    @@mastermind = MasterMind.new
    @@count = 0
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
        @message = "Welcome to TicTacToe"
    	erb :tictactoe
    end
    
    post '/home' do
        @message = "Welcome to Jake's Game Imporium"
    	erb :index
    end
    
end