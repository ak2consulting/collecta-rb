%w[
  blather
  blather/client/client

  collecta/pubsub
  collecta/archive
  collecta/result
  collecta/subscribe
].each { |r| require r }

module Collecta
  COLLECTA_JID = 'search.collecta.com'.freeze
  HOST = 'guest.collecta.com'.freeze
  NODE = 'search'.freeze

  class Client < Blather::Client
    attr_accessor :api_key # :nodoc:

    # Setup the connection with an API key
    def self.setup(apikey)
      new_client = super "@#{HOST}", nil
      new_client.api_key = apikey
      new_client
    end

    def initialize # :nodoc:
      super
      @deferred = []
    end

    # Subscribe to a query
    def subscribe(search, &block)
      return if defer(:subscribe, search, &block)
      self.write Subscribe.new self.api_key, search
      self.register_handler(:pubsub_event, "//ns:headers/ns:header[@name='x-collecta#query' and .='#{search}']", :ns => 'http://jabber.org/protocol/shim') do |evt, _|
        block.call Result.new.inherit(evt)
      end
    end

    # Subscribe to query notifications
    def notifications(search, &block)
      return if defer(:notifications, search, &block)
      self.write Subscribe.new self.api_key, nil, search
      self.register_handler(:pubsub_event, "//ns:item[@id='#{search}']", :ns => 'http://jabber.org/protocol/pubsub#event') do |evt, item|
        block.call item.first.find('//ns:count', :ns => 'http://api.collecta.com/ns/search-0#notify').first.content.to_i
      end
    end

    # Retrieve the last set of entries for <tt>search</tt>
    def archive(search, &block)
      return if defer(:archive, search, &block)
      self.write_with_handler Archive.new(self.api_key, search), &block
    end

    # Collecta doesn't seem to like stanzas with whitespace so clear it out
    def write(stanza) # :nodoc:
      super stanza.to_xml(:indent => 0).gsub(/\n|\r/,'')
    end

    # Allow users to setup callbacks before the connection is setup
    def defer(*args, &block) # :nodoc:
      if @stream
        false
      else
        @deferred << [args, block]
        true
      end
    end

    # Run all deferred commands after the connection is established
    def post_init(stream, jid = nil) # :nodoc:
      super
      until @deferred.empty?
        args = @deferred.pop
        self.__send__ *(args[0]), &args[1]
      end
    end

    def client_post_init # :nodoc:
      # overwrite the default actions to take after a client is setup
    end
  end

end