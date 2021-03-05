Gem::Specification.new do |s|
  s.name          = 'logstash-filter-cusum'
  s.version       = '0.1.0'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'The cusum filter performs a cumulative sum'
  s.description   = 'This filter does a cumulative sum and overrides event fields with its value'
  s.homepage      = 'https://github.com/deletX/logstash-filter-cusum'
  s.authors       = ['Stefano Gavioli']
  s.email         = 'stefano@stefanogavioli.eu'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60", "<= 2.99" 
  s.add_development_dependency 'logstash-devutils'
end
