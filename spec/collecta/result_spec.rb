require 'spec_helper'

describe Collecta::Result do
  before do
    @result = Collecta::Result.new.inherit(Blather::XMPPNode.import(Nokogiri::XML.parse(<<-XML).root))
    <message from='search.collecta.com'
             to='tofu@collecta.com/search'>
      <event xmlns='http://jabber.org/protocol/pubsub#event'>
        <items node='search'>
          <item id='1cb57d9c-1c46-11dd-838c-001143d5d5db'>
            <entry xmlns="http://www.w3.org/2005/Atom">
              <source>
                <title>metajack</title>
                <icon>http://identi.ca/avatar/4685-96-20090213165024.jpeg</icon>
                <author>
                  <name>metajack</name>
                </author>
                <link href="http://identi.ca/metajack"/>
                <link href="http://identi.ca/metajack" type="application/atom+xml" rel="self"/>
                <link href="http://creativecommons.org/licenses/by/3.0/" rel="license"/>
              </source>
              <link href="http://identi.ca/metajack"/>
              <title>metajack</title>
              <published>2009-04-25T04:03:38+00:00</published>
              <id>http://identi.ca/notice/3694388</id>
              <updated>1970-01-01T00:00:00+00:00</updated>
              <category xmlns="http://api.collecta.com/ns/search-0#results">update</category>
              <abstract xmlns="http://api.collecta.com/ns/search-0#results">
                <p>metajack Great. My first day back in SF and there's an earthquake.</p>
              </abstract>
              <link rel='collecta-abstract-image' href='http://identi.ca/avatar/4685-96-20090213165024.jpeg'/>
            </entry>
          </item>
        </items>
      </event>
      <headers xmlns='http://jabber.org/protocol/shim'>
        <header name='x-collecta#query'>
          earthquake
        </header>
      </headers>
    </message>
    XML
  end

  it 'has a query' do
    @result.query.must_equal 'earthquake'
  end

  it 'has a title' do
    @result.title.must_equal 'metajack'
  end

  it 'has a category' do
    @result.category.must_equal 'update'
  end

  it 'has an abstract' do
    @result.abstract.must_equal "<p>metajack Great. My first day back in SF and there's an earthquake.</p>"
  end
end
