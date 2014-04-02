require 'sinatra/base'
require 'uri'
require './lib/link'
require './lib/link_repo'


class UrlApp < Sinatra::Application

  URL_DATA = []
  DOMAIN = ""
  ERROR_MESSAGE = {}
  LINK_REPO = LinkRepo.new

  get '/' do
    DOMAIN = request.url
    if ERROR_MESSAGE[:status] == true
      ERROR_MESSAGE[:status] = false
      erb :homepage, :locals => {:error => ERROR_MESSAGE[:error_message]}
    else
      ERROR_MESSAGE[:error_message] = ""
      erb :homepage, :locals => {:error => ERROR_MESSAGE[:error_message]}
    end
  end

  post '/' do
    new_link = Link.new(params[:full_url])
    if new_link.is_url_empty?
      ERROR_MESSAGE = {:error_message => "URL cannot be blank", status: true}
      redirect '/'
    end
    puts new_link.old_url
    if new_link.is_url?
      LINK_REPO.add(new_link.old_url)
      stats = LINK_REPO.links.last[:stats]
      redirect "/#{LINK_REPO.links.last[:id]}?stats=#{stats}"
    else
      ERROR_MESSAGE = {:error_message => "The text you entered is not a valid URL", status: true}
      redirect '/'
    end
  end

  get '/:id' do
    link = LINK_REPO.links[(params[:id].to_i) - 1]
    if params[:stats]
      erb :new_link_page, :locals => {:url_to_redirect_to => link[:url_to_redirect_to], :id => params[:id], :domain => DOMAIN}
    else
      redirect link[:url_to_redirect_to]
    end
  end
end