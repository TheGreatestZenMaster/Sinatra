require 'sinatra'

class WebPortfolio<Sinatra::Base
    
    get '/' do
    	@message = "Welcome to Jake's Game Imporium"
    	erb :index
    end
    
    post '/mastermind' do
        @message = "Welcome to Mastermind"
    	erb :mastermind
    end
    
    post '/tictactoe' do
        @message = "Welcome to TicTacToe"
    	erb :tictactoe
    end
    
end