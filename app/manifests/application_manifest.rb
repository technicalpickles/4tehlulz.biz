require 'moonshine'
require 'moonshine/mongodb'

class ApplicationManifest < Moonshine::Manifest::Sinatra
  include Moonshine::Mongodb
  recipe :default_stack, :mongodb

  def application_packages
    # fixme, find what needs these
    package 'libcurl4-openssl-dev', :before => exec('bundle install')
  end

  recipe :application_packages
end
