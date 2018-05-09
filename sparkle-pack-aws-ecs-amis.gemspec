Gem::Specification.new do |s|
  s.name = 'sparkle-pack-aws-ecs-amis'
  s.version = '0.1.0'
  s.license = 'Apache-2.0'
  s.summary = 'AWS ECS optimized AMIs'
  s.description = 'SparklePack to dynamically detect AWS ECS optimized AMIs and provide them as a template mapping'
  s.author = 'Sean Escriva'
  s.email = 'sean.escriva@gmail.com'
  s.homepage = 'https://github.com/webframp/sparkle-pack-aws-ecs-amis'
  s.files = Dir['lib/sparkleformation/registry/*'] + %w[sparkle-pack-aws-ecs-amis.gemspec lib/sparkle-pack-aws-ecs-amis.rb README.md]
  s.add_runtime_dependency 'aws-sdk-core', '~> 2.11'
  s.add_runtime_dependency 'sparkle_formation', '~> 0'
end
