require 'sinatra'
require 'sinatra/reloader'

set :number, rand(101)

def check_guess(guess)
    if guess > settings.number
        message = "Too high!"
        if guess - settings.number >= 15
            color = "darkred"
        elsif guess - settings.number <= 5
            color = "palevioletred"
        else
            color = "red"
        end
    elsif guess < settings.number
        message = "Too low!"
        if settings.number - guess >= 15
            color = "darkred"
        elsif settings.number - guess <= 5
            color = "palevioletred"
        else
            color = "red"
        end
    else
        message = "That is correct! The Secret Number was #{guess}!"
        color = "green"
    end
    return color, message
end

get '/' do
    guess = params['guess'].to_i
    color, message = check_guess(guess)
    erb :index, :locals => {:number => settings.number, :guess => guess, :message => message, :color => color}
end