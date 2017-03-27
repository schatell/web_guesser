require 'sinatra'
require 'sinatra/reloader'

relevant_color = 'white'
chance_left = 5

set :number, rand(101)

get '/' do
  if chance_left == 0
    relevant_color = 'white'
    chance_left = 5
    settings.number = rand(100)
    redirect "/"
  end
  if params["guess"] != nil && chance_left >= 0
    chance_left -= 1
    message = guess_message(settings.number, params["guess"].to_i)
    relevant_color = set_background(message)
   else
     "enter a guess"
   end
  erb :index, :locals => {:number => settings.number, :message => message, :guess => params["guess"], :relevant_color => relevant_color, :chance_left => chance_left}
end

post "/" do
  chance_left = 5
  relevant_color = 'white'
  settings.number = rand(100)
  redirect "/"
end

def guess_message(number, guess)
  if guess - number < -5
    "Way too low!"
  elsif guess - number > 5
    "Way too high!"
  elsif guess > number
    "Too high!"
  elsif guess < number
    "Too low!"
  else
    "You win!"
  end
end

def set_background(message)
  if message == "You win!"
    relevant_color = '#BCF5A9'
	elsif message == "Way too high!"
    relevant_color = '#FA5858'
	elsif message ==  "Too high!"
    relevant_color = '#F5A9A9'
	elsif message == "Way too low!"
    relevant_color = '#FA5858'
	elsif message == "Too low!"
    relevant_color = '#F5A9A9'
	else
    relevant_color = 'white'
	end
end
