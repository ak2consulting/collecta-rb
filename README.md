Collecta.rb
===========

A ruby library based on Blather for working with the Collecta XMPP api.

Install
-------
Gem is hosted on [Gemcutter](http://gemcutter.org/)

    sudo gem install collecta-rb

Example
-------

    require 'rubygems'
    require 'collecta-rb'
    require 'pp'

    client = Collecta::Client.setup '[api-key]'

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


Copyright
---------

Copyright (c) 2009 Jeff Smick. See LICENSE for details.
