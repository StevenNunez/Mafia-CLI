require_relative '../config/environment'

class MafiaApp < Sinatra::Base
  enable :sessions
  set :session_secret, 'kjfhalskjkjlakjhoihoh'

  get '/' do
    erb :index
  end

  get '/play' do
    erb :play
  end

  get '/games.json' do
    content_type :json
    Game.all.to_json
  end

  post '/games' do
    game = Game.create(label: params[:label])
    session[:game_id] = game.id
  end

  post '/join/:id' do
    game = Game.find(params[:id])
    session[:game_id] = game.id
    201
  end

  post '/sleep.json' do
    content_type :json
    game = Game.find(session[:game_id])
    murdered = game.mafia_kill
    {name: murdered}.to_json
  end
end
