module Collecta
  class Result < Blather::Stanza::PubSub::Event
    def query
      content_from('//ns:headers/ns:header[@name="x-collecta#query"]', :ns => 'http://jabber.org/protocol/shim').strip
    end

    def title
      self.entry.content_from '//ns:title', :ns => 'http://www.w3.org/2005/Atom'
    end

    def category
      self.entry.content_from '//ns:category', :ns => 'http://api.collecta.com/ns/search-0#results'
    end

    def abstract
      self.entry.find('//ns:abstract', :ns => 'http://api.collecta.com/ns/search-0#results').first.inner_html.strip
    end

    def entry
      Blather::XMPPNode.new('event').inherit self.items.first.find_first('//ns:entry', :ns => 'http://www.w3.org/2005/Atom')
    end
  end
end
