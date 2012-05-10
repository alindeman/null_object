# NullObject

Dead simple library to create null objects (objects that respond to all
messages)

## Usage

Respond to ALL the things:

```ruby
obj = NullObject.new
obj.foo # => nil
obj.bar # => nil
```

Respond to SOME of the things:

```ruby
obj = NullObject.new(:foo, :bar)
obj.foo # => nil
obj.bar # => nil
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

Respond to ALL of the things with `self`:

```ruby
obj = NullObject.new { obj }
obj.foo         # => obj
obj.foo.bar.baz # => obj
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
