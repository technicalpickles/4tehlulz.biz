require 'mongo_mapper'
require 'joint'
require '4tehlulz/extensions'

class Lulz
  include MongoMapper::Document
  plugin Joint

  key :imgur_url, String

  attachment :result
end

