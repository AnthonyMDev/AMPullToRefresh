Pod::Spec.new do |s|
  s.platform     = :ios
  s.ios.deployment_target = '7.0'
  s.name         = 'AMPullToRefresh'
  s.version      = '0.1.0'
  s.summary      = 'A controller to add a pull to refresh view to a scroll view.'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Anthony Miller" => "AnthonyMDev@gmail.com" }
  s.source   	 = { :git => 'https://bitbucket.org/anthonymdev/ampulltorefresh.git',
                     :tag => "#{s.version}"}
  s.requires_arc = true
  s.resource_bundles = {'AMPullToRefreshBundle' => ['AMPullToRefresh/Resources/*']}
  s.frameworks = 'UIKit'
  
  s.source_files = 'AMPullToRefresh/*.{h,m}'
end