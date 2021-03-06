

Pod::Spec.new do |s|
  s.name = 'GameObjects'
  s.version = '0.0.1'
  s.license = 'WTFPL'
  s.summary = 'Objects for games'
  s.authors = { 'bryn austin bellomy' => 'bryn.bellomy@gmail.com' }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.source_files = 'src/*.swift', 'src/**/*.swift'

  s.dependency 'LlamaKit'

  s.dependency 'Funky', '0.1.2'
  s.dependency 'SwiftBitmask'
  s.dependency 'SwiftConfig'
  s.dependency 'SwiftLogger'
  s.dependency 'SwiftDataStructures'
  s.dependency 'BrynSwift'
  s.dependency 'Signals'

  s.frameworks = ['SpriteKit', 'LlamaKit']

  s.homepage = 'https://github.com/brynbellomy/GameObjects'
  s.source = { :git => 'https://github.com/brynbellomy/GameObjects.git', :tag => '0.0.1' }
end
