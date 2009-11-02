require 'spec_helper'

describe Collecta::Subscribe do
  it 'can be created with an apikey, a search term and a notify term' do
    subscription = Collecta::Subscribe.new 'apikey-value', 'search-term', 'notify-term'
    subscription.must_be_kind_of Blather::Stanza::PubSub::Subscribe
    subscription.must_have_apikey 'apikey-value'
    subscription.must_have_query 'search-term'
    subscription.must_have_notify 'notify-term'
  end
end
