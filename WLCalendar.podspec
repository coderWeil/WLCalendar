
Pod::Spec.new do |spec|

  spec.name         = "WLCalendar"
  spec.version      = "0.0.4"
  spec.summary      = "日历表"
  spec.description  = "日历表定制，支持单一日历，单一日历可动态计算日历高度(即5行或者6行)，支持多个月份日历的滚动显示(只支持一页6行42个的样式)"
  spec.homepage     = "https://github.com/weilLove/WLCalendar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "weilLove" => "weil218@163.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/weilLove/WLCalendar.git", :tag => "#{spec.version}" }
spec.subspec 'Core' do |sub|
sub.source_files = "WLCalendar/Core/*.{h,m}"
sub.frameworks = "UIKit", "Foundation"
end

end
