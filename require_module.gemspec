Gem::Specification.new do |s|
  s.name = 'require_module'
  s.version = '0.0.1'
  s.authors = ['Sergey Homa']
  s.email = 'melgaardbjorn@gmail.com'
  s.summary = 'Will evaluate file content inside Module.new'

  s.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.homepage = 'http://github.com/jarmo/require_all'
  s.license = 'MIT'

  s.has_rdoc = true
  s.rdoc_options = %w[--title require_all --main README.md --line-numbers]
  s.extra_rdoc_files = ['LICENSE', 'README.md', 'CHANGES']

  s.add_development_dependency 'rake',  '~> 10.4'
  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'simplecov', '~> 0.7'
end
