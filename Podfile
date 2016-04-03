# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

def testing_pods
  pod 'Quick', '~> 0.9.1'
  pod 'Nimble', '~> 3.2.0'
end

target 'Icicle' do
  pod 'Argo', '~> 2.3.0'
  pod 'Runes', '~> 3.2.0'
end

target 'IcicleTests' do
  testing_pods
end

target 'IcicleUITests' do
  testing_pods
end

