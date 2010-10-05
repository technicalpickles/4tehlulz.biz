require 'sinatra'
require 'rack-flash'

require 'app'

use Rack::Session::Cookie
use Rack::Flash, :accessorize => [:notice, :error]
run ForTehLols
