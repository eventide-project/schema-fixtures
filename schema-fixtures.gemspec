# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-schema-fixtures'
  s.summary = 'TestBench fixtures for the Schema library'
  s.version = '1.0.0.3'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/schema-fixtures'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-schema'
  s.add_runtime_dependency 'test_bench-fixture'

  s.add_development_dependency 'test_bench'
end
