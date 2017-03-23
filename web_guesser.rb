require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)

get '/' do
  message = if params["guess"]
     guess_message(settings.number, params["guess"].to_i)
   else
     "enter a guess"
   end
  erb :index, :locals => {:number => settings.number, :message => message, :guess => params["guess"]}
end

post "/" do
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
