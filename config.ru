require 'sinatra'
require 'rack-flash'

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"
require '4tehlulz'

use Rack::Session::Cookie
use Rack::Flash, :accessorize => [:notice, :error]
run ForTehLols
