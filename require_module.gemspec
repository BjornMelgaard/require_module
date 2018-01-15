Gem::Specification.new do |s|
  s.name    = 'require_module'
  s.version = '0.0.1'
  s.authors = ['Sergey Homa']
  s.email   = 'melgaardbjorn@gmail.com'
  s.summary = 'Evaluates file content inside Module.new, with cache'

  s.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.homepage = 'https://github.com/BjornMelgaard/require_module'
  s.license  = 'MIT'

  s.has_rdoc         = true
  s.rdoc_options     = %w[--title require_all --main README.md --line-numbers]
  s.extra_rdoc_files = ['LICENSE', 'README.md']
end
