require 'sinatra'
require './tictactoe.rb'

class TicTacToe<Sinatra::Base
    @@game = Game.new
    
    get '/' do
        erb :index
    end
    
    post '/tictactoe' do
        guess = params['guess']
        begin
			@@game.get_human_guess(guess)
		end until @@game.valid
		guess = @@game.guess
        erb :game, :locals => {:guess => guess}
    end
end

