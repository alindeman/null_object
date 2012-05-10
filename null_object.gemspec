# -*- encoding: utf-8 -*-
require File.expand_path('../lib/null_object/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andy Lindeman"]
  gem.email         = ["alindeman@gmail.com"]
  gem.description   = %q{Dead simple library to create null objects (objects that respond to all messages)}
  gem.summary       = %q{Respond to ALL the things}
  gem.homepage      = "https://github.com/alindeman/null_object"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "null_object"
  gem.require_paths = ["lib"]
  gem.version       = NullObject::VERSION

  gem.add_development_dependency "rspec", "~>2.10.0"
  gem.add_development_dependency "bourne", "~>1.1.2"
  gem.add_development_dependency "rake"
end
