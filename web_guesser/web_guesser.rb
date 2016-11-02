require 'sinatra'
require 'sinatra/reloader'

@@guesses = 6
SECRET_NUMBER = rand(100)

get '/' do
    guess = params['guess'].to_i
    message = check_guess(guess)

    if @@guesses == 1 && guess != SECRET_NUMBER
        message = "Sorry you lose!"
        @@guesses = 5
        SECRET_NUMBER = rand(100)
        color = "white"
    elsif SECRET_NUMBER == guess
        @@guesses = 5
        SECRET_NUMBER = rand(100)
        color = "green"
    else
        @@guesses -= 1
        color = set_color((guess - SECRET_NUMBER).abs)
    end
    
    erb :index, :locals => {:number => SECRET_NUMBER, :guess => guess, :message => message, :color => color, :guesses => @@guesses}
end


def check_guess(guess)
    if guess > SECRET_NUMBER
        message = "Too high!"
    elsif guess < SECRET_NUMBER
        message = "Too low!"
    else
        message = "That is correct! The Secret Number was #{guess}!"
    end
   message
end

def set_color(guess)
    if guess >= 15
        color = "darkred"
    elsif guess > 5 && guess < 15
        color = "red"
    elsif guess > 0 && guess <= 5
        color = "palevioletred"
    end
    color
end