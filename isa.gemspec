Gem::Specification.new do |s|
  s.name        = 'isa'
  s.version     = '1.0.0'
  s.date        = '2014-02-17'
  s.summary     = 'Image Session Analyzer'
  s.description = 'Analysis tool for investigating screenshots taken over a session'
  s.authors     = ['David Buckhurst']
  s.email       = 'david.buckhurst@bbc.co.uk'
  s.files       = [ 'lib/isa/session.rb' ]
  s.homepage    = 'https://github.com/bbc-test/isa'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rmagick'
end
