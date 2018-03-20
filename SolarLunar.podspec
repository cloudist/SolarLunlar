Pod::Spec.new do |s|
  s.name         = "SolarLunar"
  s.version      = "1.0.0"
  s.summary      = "Solar <-> Lunar"
  s.description  = <<-DESC
   A tiny tool for Solar <-> Lunar
                   DESC

  s.homepage     = "https://github.com/Cloudist/SolarLunar"
  s.license      = "MIT"
  s.authors            = { "liubo" => "liubo@cloudist.cc", "caochen" => "caochen@cloudist.cc" }
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/Cloudist/SolarLunar.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/*.swift"
  s.requires_arc = true

end
