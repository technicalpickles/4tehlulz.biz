require 'sinatra/base'
require 'sinatra/mongomapper'
require 'joint'
require 'imgur'

require 'tempfile'

require '4tehlulz/extensions'
require '4tehlulz/montage'

class Lulz
  include MongoMapper::Document
  plugin Joint

  key :imgur_url, String

  attachment :result
end

# Specify the database to use. *Required*
set :mongomapper, 'mongomapper://localhost:27017/4tehlulz'

module ForTehLulz
  class App < Sinatra::Base

    get '/' do
      @lulz = Lulz.all
      @last_lulz = Lulz.find_by_id(session[:last_lulz_id]) if session[:last_lulz_id]
      haml :index 
    end

    get '/uploads/:upload' do
      content_type 'image/jpeg'
      lulz = Lulz.find_by_id(params[:upload])

      lulz.result
    end

    post '/' do
      first_panel = newly_uploaded_path(params[:first_panel])
      second_panel = gallery_path(params[:second_panel])
      third_panel = newly_uploaded_path(params[:third_panel])
      fourth_panel = gallery_path(params[:fourth_panel])

      montage = Montage.go! first_panel, second_panel, third_panel, fourth_panel

      imgur = Imgur::API.new('73c65910d8f5fe205d986b8b9f932ea0')
      uploaded_image = imgur.upload_file(montage.path)

      lulz = Lulz.create! :result => montage, :imgur_url => uploaded_image['original_image']

      flash[:notice] = "Uploaded!"
      session[:last_lulz_id] = lulz.id
      redirect "/"
    end

    def gallery_path(selection)
      "public/gallery/#{selection}.jpg"
    end

    def newly_uploaded_path(selection)
      selection[:tempfile].path 
    end
  end
end
