lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'worker_glass/version'

Gem::Specification.new do |spec|
  spec.name          = "worker-glass"
  spec.version       = WorkerGlass::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Maciej Mensfeld', 'Pavlo Vavruk']
  spec.email         = %w( maciej@mensfeld.pl pavlo.vavruk@gmail.com )
  spec.summary       = 'Timeout and Reentrancy for your background processing workers!'
  spec.description   = 'Background worker wrappers that provides optional timeout and after failure (reentrancy)'
  spec.homepage      = 'https://github.com/karafka/worker-glass'
  spec.license       = 'MIT'

  spec.add_dependency 'null-logger'
  spec.add_dependency 'activesupport'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w( lib )
end
