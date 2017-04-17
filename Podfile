project 'SwiftSky.xcodeproj'
use_frameworks!

abstract_target 'Framework' do
  pod 'Alamofire', '~> 4.4'

  target 'SwiftSky iOS' do
    platform :ios, '8.0'
  end
  
  target 'SwiftSky macOS' do
    platform :osx, '10.10'
  end
  
  target 'SwiftSky tvOS' do
    platform :tvos, '9.0'
  end
  
  target 'SwiftSky watchOS' do
    platform :watchos, '2.0'
  end
  
  abstract_target 'Testing' do
    pod 'OHHTTPStubs/Swift'
    pod 'Quick'
    pod 'Nimble'
    
    target 'SwiftSky iOS Tests' do
      platform :ios, '8.0'
    end
    
    target 'SwiftSky macOS Tests' do
      platform :osx, '10.10'
    end
    
    target 'SwiftSky tvOS Tests' do
      platform :tvos, '9.0'
    end
   
  end
  
end
