require 'sinatra'
require './tictactoe.rb'

class TicTacToe<Sinatra::Base
    @@game = Game.new
	@@count = 1
	@@spaces = [:one, :two, :three, :four, :five, :six, :seven, :eight, :nine].to_a
	
    get '/' do
    	message = "When you're ready!"
    	board = @@game.display.board
    	@spaces = @@spaces
        erb :index, :locals => { :board => board, :message => message }
    end
    post '/tictactoe' do
    	@spaces = @@spaces
    	@@count += 1
    	@count = @@count % 2
    	board = @@game.display.board
    	puts params.inspect
    	@move = params.keys[0]
    	if params['reset']
    		message = @@game.reset_game
    		board = @@game.display.board
    		erb :index, :locals => { :board => board, :message => message }
    	else
	    	if valid(params[@move])
	    		update(params[@move], @move.to_sym)
	    		message = "Nice Move!"
			else
				message = "That's not a valid input!"
			end
			message = "Tie!" if check_for_tie
			message = "Yeah! You won!" if check_for_victory(params[@move])
			erb :index, :locals => { :board => board, :message => message}
		end
    end

    def update(symbol, location)
		@@game.display.board[location] = symbol
	end
	
	def valid(num)
		valid = false
		if num == 'X' || num == 'O'
			valid = true
		end
		valid
	end
	
	def check_for_victory(symbol)
		victory = false
		victory_conditions = [[:one, :two, :three], [:four, :five, :six], [:seven, :eight, :nine], [:one, :four, :seven],[:two, :five, :eight],[:three, :six, :nine],[:one, :five, :nine],[:seven, :five, :three]].to_a
		victory_conditions.each do |sub_array|
			if @@game.display.board[sub_array[0]] == symbol && @@game.display.board[sub_array [1]] == symbol && @@game.display.board[sub_array[2]] == symbol
				victory = true
			end
		end
		return victory
	end
	
	def check_for_tie
		tie = false
		tie = true if @@game.display.board.all?{|x,y| y.is_a?(String)}
		tie
	end
end
