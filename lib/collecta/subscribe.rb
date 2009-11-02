module Collecta
  class Subscribe < Blather::Stanza::PubSub::Subscribe
    include Collecta::Pubsub
    def self.new(apikey, query = nil, notify = nil)
      new_node = super :set, COLLECTA_JID, NODE
      new_node.apikey = apikey
      new_node.query = query
      new_node.notify = notify if notify
      new_node
    end
  end
end
