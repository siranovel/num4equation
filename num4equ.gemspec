Gem::Specification.new do |s|
  s.name        = 'num4equ'
  s.version     = '0.0.8'
  s.date        = '2023-04-16'
  s.summary     = "num for equation"
  s.description = "numerical solution for equation"
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "http://github.com/siranovel/num4equation"
  s.metadata    = {
      'changelog_uri'     => 'http://github.com/siranovel/num4equation/blob/main/CHANGELOG.md',
      'documentation_uri' => "https://rubydoc.info/gems/#{s.name}/#{s.version}",
      'homepage_uri'      => s.homepage,
  }
  s.license     = "MIT"
  s.files       = ["LICENSE", "Gemfile", "CHANGELOG.md"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.extensions  = %w[ext/num4equ/Rakefile]
  s.add_dependency 'ffi-compiler', '~> 1.0', '>= 1.0.1'
  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
end
