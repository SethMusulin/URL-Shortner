require 'sinatra/base'

class UrlApp < Sinatra::Application

  URL_DATA = []

  get '/' do
    erb :homepage, :locals => {:urls => URL_DATA}
  end

  post '/' do
    full_url = params[:full_url]
    URL_DATA << full_url
    index = URL_DATA.find_index(full_url) + 1

    redirect "/#{index}"
  end

  get '/:index' do
    old_url = URL_DATA[params[:index].to_i - 1]
    index = params[:index]
    erb :new_link_page, :locals => {:old_url => old_url, :index => index}
  end
end