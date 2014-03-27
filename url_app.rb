require 'sinatra/base'

class UrlApp < Sinatra::Application

  get '/' do
    erb :homepage
  end
end