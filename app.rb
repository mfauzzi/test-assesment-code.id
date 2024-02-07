require 'sinatra'
require_relative 'tic-tac-toe'

enable :sessions

get '/' do
  session.clear  # Clear session data
  erb :index
end

post '/play' do
  begin
    player_one_name = params[:player_one_name]
    player_two_name = params[:player_two_name]
    input = params[:input].split.map(&:to_i)

    game = Game.new(player_one_name, player_two_name)
    game.make_move(input, 0)  # Assume it's player one's turn to start
    game.play_game

    session[:result] = if Game.class_variable_get(:@@winner)
                "#{Game.class_variable_get(:@@winner)} wins the game!"
              else
                "It's a tie!"
              end

    redirect '/result'
  rescue => e
    status 400
    "Error: #{e.message}"
  end
end

get '/result' do
  @result = session.delete(:result)
  erb :result
end
