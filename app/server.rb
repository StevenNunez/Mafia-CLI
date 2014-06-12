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
    201
  end

  get '/game.json' do
    content_type :json
    game = Game.find(session[:game_id])
    {
      label: game.label,
      townsPeople: game.students
    }.to_json
  end

  post '/join/:id' do
    game = Game.find(params[:id])
    session[:game_id] = game.id
    201
  end

  post '/kill.json' do
    content_type :json
    game = Game.find(session[:game_id])
    mafia_status = game.mob_kill(params[:dead])
    mafia_status.to_json
  end

  post '/sleep.json' do
    content_type :json
    game = Game.find(session[:game_id])
    murdered = game.mafia_kill
    {name: murdered}.to_json
  end
end
