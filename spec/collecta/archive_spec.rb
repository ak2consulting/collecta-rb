require 'spec_helper'

describe Collecta::Archive do
  it 'can be created with an apikey and a search term' do
    archive = Collecta::Archive.new 'apikey-value', 'search-term'
    archive.must_be_kind_of Blather::Stanza::PubSub::Items
    archive.must_have_apikey 'apikey-value'
    archive.must_have_query 'search-term'
  end
end
