require 'rubygems'
require 'minitest/spec'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), *%w[.. lib]))
require 'collecta-rb'

MiniTest::Unit.autorun

module MiniTest
  require 'pathname' if MINI_DIR =~ %r{^./}

  module Assertions
    def assert_has_apikey(key, node, msg = nil)
      msg = message(msg) { "Expected #{mu_pp(node)} to have API key #{mu_pp(key)}" }
      assert(node.apikey == key, msg)
    end

    def assert_has_query(query, node, msg = nil)
      msg = message(msg) { "Expected #{mu_pp(node)} to have query #{mu_pp(query)}" }
      assert(node.query.include?(query), msg)
    end

    def assert_has_notify(notify, node, msg = nil)
      msg = message(msg) { "Expected #{mu_pp(node)} to have query #{mu_pp(notify)}" }
      assert(node.notify.include?(notify), msg)
    end
  end
end

class Object
  def must_have_apikey *args
    return MiniTest::Spec.current.assert_has_apikey(args.first, self)
  end

  def must_have_query *args
    return MiniTest::Spec.current.assert_has_query(args.first, self)
  end

  def must_have_notify *args
    return MiniTest::Spec.current.assert_has_notify(args.first, self)
  end
end
