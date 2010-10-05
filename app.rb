require 'sinatra/base'

class ForTehLols < Sinatra::Base
  get '/' do
    haml :index 
  end

  get '/uploads/:upload' do
    content_type 'image/jpeg'
    send_file "system/#{params[:upload]}.jpg"
  end

  post '/' do
    first_panel = newly_uploaded_path(params[:first_panel])
    second_panel = gallery_path(params[:second_panel])
    third_panel = newly_uploaded_path(params[:third_panel])
    fourth_panel = gallery_path(params[:fourth_panel])

    timestamp = Time.now.strftime("%y%m%d%H%M")
    command = "montage '#{first_panel}' '#{second_panel}' '#{third_panel}' '#{fourth_panel}' -background '#000000' -geometry '+0+0' -tile 1 'system/#{timestamp}.jpg'"
    
    system command

    flash[:notice] = "Uploaded!"
    session[:uploaded_id] = timestamp
    redirect "/"
  end

  def gallery_path(selection)
    "gallery/#{selection}.jpg"
  end

  def newly_uploaded_path(selection)
    selection[:tempfile].path 
  end
end
