# NullObject

[![Build Status](https://secure.travis-ci.org/alindeman/null_object.png)](http://travis-ci.org/alindeman/null_object)

Dead simple library to create null objects (objects that respond to all
messages)

## Requirements

* MRI 1.9, JRuby in 1.9 mode (`JRUBY_OPTS=--1.9`), Rubinius in 1.9 mode
  (`RBXOPT=-X19`)

## Why?

Imagine that sometimes your code uses a [statsd](https://github.com/etsy/statsd)
client to instrument itself. But only sometimes.

If you used `nil` to represent the case where the statsd client isn't configured,
you end up writing code like this ... which sucks:

```ruby
statsd.increment("foo") if statsd
```

And how to you deal with timers? I have no idea

```ruby
# statsd might be nil, ugh!
statsd.time("foo") { ... }
```

But if your `statsd` were either a real `Statsd` client **or a `NullObject`**,
the problems go away:

```
statsd = NullObject.new { |&block| block.call if block }

statsd.increment("foo")    # no need for a conditional; it's a no-op
statsd.time("foo") { ... } # yields to the block, but otherwise a no-op
```

## Usage

Respond to ALL the things:

```ruby
obj = NullObject.new
obj.foo     # => obj
obj.bar     # => obj
obj.foo.bar # => obj
```

Yield ALL the things:

```ruby
obj = NullObject.new { |&block| block.call if block }
obj.foo { puts "bar" } # outputs "bar"
```

Respond to SOME of the things:

```ruby
obj = NullObject.new(:foo, :bar)
obj.foo # => obj
obj.bar # => obj
obj.baz # raises NoMethodError
```

Respond to SOME of the things with CERTAIN return values:

```ruby
obj = NullObject.new(:foo => :bar)
obj.foo # => :bar
obj.baz # raises NoMethodError
```

Respond to ALL of the things with a CERTAIN return value:

```ruby
obj = NullObject.new { "foo" }
obj.foo # => "foo"
obj.bar # => "foo"
```

Respond to ALL of the things with nil:

```ruby
obj = NullObject.new { nil }
obj.foo # => nil
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
