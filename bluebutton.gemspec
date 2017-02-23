Gem::Specification.new do |s|
  s.name = 'bluebutton'
  s.summary = 'Deal with Bluetooth button aka selfy shutter'
  s.description = <<EOF
Simple daemon that allows you to execute action when bluetooth button shutter pressed. So you can control your PC by low energy button device and few scripts.
EOF
  s.authors = ["Samoilenko Yuri"]
  s.homepage = 'https://github.com/kinnalru/bluebutton'
  s.license = 'GPL-3.0'
  s.files = %w(
README.md
lib/bluebutton.rb
bin/bluebutton
VERSION
)
  s.executables = ['bluebutton']

  s.required_ruby_version = "~> 2"
  s.add_runtime_dependency "device_input"
  s.add_runtime_dependency "slop"

  s.version = File.read(File.join(__dir__, 'VERSION')).chomp
end
