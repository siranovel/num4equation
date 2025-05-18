Gem::Specification.new do |s|
  s.name        = 'num4equ'
  s.version     = '0.2.1'
  s.date        = '2025-05-15'
  s.summary     = "num for equation"
  s.description = "numerical solution for equation"
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "http://github.com/siranovel/num4equation"
  s.metadata    = {
      'changelog_uri'     => s.homepage + '/blob/main/CHANGELOG.md',
      'documentation_uri' => "https://rubydoc.info/gems/#{s.name}/#{s.version}",
      'homepage_uri'      => s.homepage,
      'wiki_uri'          => 'https://github.com/siranovel/mydocs/tree/main/num4equation',
  }
  s.license     = "MIT"
  s.required_ruby_version = ">= 3.0"
  s.files       = ["LICENSE", "Gemfile", "CHANGELOG.md"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.extensions  = %w[ext/num4equ/Rakefile]
  s.add_dependency 'rake', '~> 13', '>= 13.0.6'
  s.add_development_dependency 'ffi-compiler', '~> 1.3', '>= 1.3.2'
end
