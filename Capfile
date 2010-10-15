load 'deploy'

$LOAD_PATH.unshift '../../railsmachine/moonshine/lib'
require 'moonshine/capistrano_integration'

server 'ec2-75-101-202-189.compute-1.amazonaws.com', :app, :db, :web, :primary => true
