Pod::Spec.new do |s|
    s.name = 'SwiftInjection'
    s.version = '0.7'
    s.summary = 'A dependency injection framework for swift'
    s.homepage = 'https://github.com/aryaxt/SwiftInjection'
    s.license = {
      :type => 'MIT',
      :file => 'License.txt'
    }
    s.author = {'Aryan Ghassemi' => 'https://github.com/aryaxt/SwiftInjection'}
    s.source = {:git => 'https://github.com/aryaxt/SwiftInjection.git', :tag => '0.7'}
    s.platform = :ios, '8.0'
    s.source_files = 'SwiftInjection/*.{swift}'
    s.framework = 'Foundation'
    s.requires_arc = true
end
