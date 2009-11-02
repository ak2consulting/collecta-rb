module Collecta
  module Pubsub
    DATA_NS = 'jabber:x:data'.freeze

    def apikey
      self.options.content_from '//ns:field[@var="x-collecta#apikey"]/ns:value', :ns => DATA_NS
    end

    def apikey=(key)
      self.add_field 'x-collecta#apikey', key
    end

    def query
      self.options.find('//ns:field[@var="x-collecta#query"]/ns:value', :ns => DATA_NS).map { |n| n.content }
    end

    def query=(values)
      self.add_field 'x-collecta#query', values
    end

    def notify
      self.options.find('//ns:field[@var="x-collecta#notify"]/ns:value', :ns => DATA_NS).map { |n| n.content }
    end

    def notify=(values)
      self.add_field 'x-collecta#notify', values
    end

  protected
    def options
      x = self.pubsub.find_first('//pubsub_ns:options/ns:x', :pubsub_ns => self.registered_ns, :ns => DATA_NS)
      unless x
        self.pubsub << (o = Blather::XMPPNode.new('options', self.document))
        o << (x = Blather::XMPPNode.new('x', self.document))
        x.namespace = 'jabber:x:data'
        x[:type] = 'submit'

        field = self.add_field('FORM_TYPE', 'http://jabber.org/protocol/pubsub#subscribe_options')
        field[:type] = 'hidden'
      end
      x
    end

    def add_field(var, values)
      self.options << (field = Blather::XMPPNode.new('field', self.document))
      field[:var] = var
      [values].flatten.each do |value|
        field << (val = Blather::XMPPNode.new('value', self.document))
        val.content = value
      end
      field
    end
  end
end
