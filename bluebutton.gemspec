Gem::Specification.new do |s|
  s.name = 'bluebutton'
  s.summary = 'Deal with Bluetooth button aka selfy button'
  s.description = <<EOF
Connect to Bluetooth button and execute action when pressed.
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
