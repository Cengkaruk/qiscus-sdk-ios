Pod::Spec.new do |s|

s.name         = "Qiscus"
s.version      = "0.0.1"
s.summary      = "Qiscus SDK for iOS"

s.description  = <<-DESC
Qiscus SDK for iOS contains Qiscus public Model.
DESC

s.homepage     = "https://qisc.us"

s.license      = "MIT"
s.author       = "Ahmad Athaullah"

s.source       = { :git => "https://a_athaullah@bitbucket.org/a_athaullah/qiscussdk.git", :tag => "#{s.version}" }


s.source_files  = "Qiscus/Qiscus/*.swift"
s.platform      = :ios, "8.0"

s.dependency 'Alamofire', , '~> 3.0'
s.dependency 'AlamofireImage'
s.dependency 'PusherSwift'
s.dependency 'RealmSwift'
s.dependency 'SwiftyJSON'

end