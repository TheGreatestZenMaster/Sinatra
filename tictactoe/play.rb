require 'sinatra'
require './tictactoe.rb'

class TicTacToe<Sinatra::Base
    @@game = Game.new

    get '/' do
    	message = "When you're ready!"
    	board = @@game.display.board
        erb :index, :locals => { :board => board, :message => message }
    end
    post '/one' do
    	board = @@game.display.board
    	if valid(params['one'])
    		update(params['one'], :one)
    		message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['one'])
        erb :index, :locals => { :board => board, :message => message}
    end
    post '/two' do
    	board = @@game.display.board
    	if valid(params['two'])
    		update(params['two'], :two)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['two'])
        erb :index, :locals => { :board => board, :message => message }
    end
    
    post '/three' do
    	board = @@game.display.board
    	if valid(params['three'])
    		update(params['three'], :three)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['three'])
        erb :index, :locals => { :board => board, :message => message }
    end
    
    post '/four' do
    	board = @@game.display.board
    	if valid(params['four'])
    		update(params['four'], :four)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['four'])
        erb :index, :locals => { :board => board, :message => message }
    end

    post '/five' do
    	board = @@game.display.board
    	if valid(params['five'])
    		update(params['five'], :five)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['five'])
        erb :index, :locals => { :board => board, :message => message }
    end
    
    post '/six' do
    	board = @@game.display.board
    	if valid(params['six'])
    		update(params['six'], :six)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['six'])
        erb :index, :locals => { :board => board, :message => message }
    end
    
    post '/seven' do
    	board = @@game.display.board
    	if valid(params['seven'])
    		update(params['seven'], :seven)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['seven'])
        erb :index, :locals => { :board => board, :message => message }
    end
    
    post '/eight' do
    	board = @@game.display.board
    	if valid(params['eight'])
    		update(params['eight'], :eight)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['eight'])
        erb :index, :locals => { :board => board, :message => message }
    end
    
    post '/nine' do
    	board = @@game.display.board
    	if valid(params['nine'])
    		update(params['nine'], :nine)
			message = "Nice Move!"
		else
			message = "That's not a valid input!"
		end
		message = "Tie!" if check_for_tie
		message = "Yeah! You won!" if check_for_victory(params['nine'])
        erb :index, :locals => { :board => board, :message => message }
    end
    post '/reset' do
    	message = @@game.reset_game
    	board = @@game.display.board
    	erb :index, :locals => { :board => board, :message => message }
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
