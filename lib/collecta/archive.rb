module Collecta
  class Archive < Blather::Stanza::PubSub::Items
    include Collecta::Pubsub
    def self.new(apikey, search)
      new_node = super :get, COLLECTA_JID
      new_node.node = NODE
      new_node.apikey = apikey
      new_node.query = search
      new_node
    end
  end
end
