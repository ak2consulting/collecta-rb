require 'rubygems'
require 'collecta-rb'
require 'pp'

client = Collecta::Client.setup 'f67a267c6d5c86ed36ae676e70698bdd'

client.subscribe('earthquake') do |result|
  pp({
    :query => result.query,
    :title => result.title,
    :category => result.category,
    :abstract => result.abstract,
  })
end

client.notifications('earthquake') do |notification|
  pp notification
end

client.archive('earthquake') do |result|
  pp result
end

EM.run { client.connect }
