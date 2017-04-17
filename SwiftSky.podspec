Pod::Spec.new do |spec|
    spec.name               = 'SwiftSky'
    spec.version            = '1.0.0'
    spec.license            = { :type => 'MIT', :file => 'LICENSE' }
    spec.homepage           = 'https://github.com/appcompany/SwiftSky'
    spec.social_media_url   = 'https://twitter.com/LucaSilverTweet'
    spec.authors            = { 'Luca Silverentand' => 'luca@appcompany.io' }
    spec.summary            = 'A cosy little Swift wrapper around the Dark Sky API'
    spec.source             = { :git => 'https://github.com/appcompany/SwiftSky.git', :tag => spec.version.to_s }
    spec.module_name        = 'SwiftSky'
    spec.documentation_url  = 'https://appcompany.github.io/SwiftSky'

    spec.ios.deployment_target      = '8.0'
    spec.osx.deployment_target      = '10.10'
    spec.watchos.deployment_target  = '2.0'
    spec.tvos.deployment_target     = '9.0'

    spec.source_files   = 'Source/**/*.swift'
    spec.framework      = 'Foundation', 'CoreLocation'
    spec.dependency 'Alamofire', '~> 4.4'
end
