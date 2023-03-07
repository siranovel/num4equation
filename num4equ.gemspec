Gem::Specification.new do |s|
  s.name        = 'num4equ'
  s.version     = '0.0.5'
  s.date        = '2023-03-04'
  s.summary     = "num for equation"
  s.description = "numerical solution for equation"
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "http://github.com/siranovel/num4equation"
  s.license     = "MIT"
  s.files       = ["LICENSE"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.extensions  = %w[ext/num4equ/Rakefile]
  s.add_dependency 'ffi-compiler', '~> 1.0', '>= 1.0.1'
  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
end
