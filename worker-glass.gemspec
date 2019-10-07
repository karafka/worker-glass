# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'worker_glass/version'

Gem::Specification.new do |spec|
  spec.name          = 'worker-glass'
  spec.version       = WorkerGlass::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Maciej Mensfeld', 'Pavlo Vavruk']
  spec.email         = %w[maciej@coditsu.io pavlo.vavruk@gmail.com]
  spec.summary       = 'Timeout and Reentrancy for your background processing workers!'
  spec.description   = 'Background worker wrappers that provides optional timeout and reentrancy'
  spec.homepage      = 'https://github.com/karafka/worker-glass'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'null-logger'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]
end
