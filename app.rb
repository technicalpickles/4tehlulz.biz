require 'sinatra/base'
require 'sinatra/mongomapper'
require 'joint'

require 'tempfile'

class Lulz
  include MongoMapper::Document
  plugin Joint

  attachment :result
end

Joint::AttachmentProxy.class_eval do
  def each
    while buf = read(8192)
      yield buf
    end
  end
end

class Montage
  attr_accessor :paths

  def initialize(*paths)
    @paths = paths
  end

  def go!
    result = Tempfile.new('montage')

    quoted_paths = paths.map do |path|
      %Q{'#{path}'}
    end

    quoted_result_path = %Q{'#{result.path}'}

    command = "montage %s -background '#000000' -geometry '+0+0' -tile 1 %s" % [quoted_paths.join(' '), quoted_result_path]
    system command

    result
  end

  def self.go!(*paths)
    new(*paths).go!
  end

end

# Specify the database to use. *Required*
set :mongomapper, 'mongomapper://localhost:27017/4tehlulz'

class ForTehLols < Sinatra::Base

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
    lulz = Lulz.create! :result => montage

    flash[:notice] = "Uploaded!"
    session[:last_lulz_id] = lulz.id
    redirect "/"
  end

  def gallery_path(selection)
    "gallery/#{selection}.jpg"
  end

  def newly_uploaded_path(selection)
    selection[:tempfile].path 
  end
end
