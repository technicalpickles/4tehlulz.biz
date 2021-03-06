require 'bundler'
Bundler.require

require 'rack-flash'
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/app/models"
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/app/sinatras"
require '4tehlulz'

use Rack::Session::Cookie
use Rack::Flash, :accessorize => [:notice, :error]
run ForTehLulz::App
