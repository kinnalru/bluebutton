#!/usr/bin/ruby

require 'device_input'

BUTTON_NAME="AB Shutter3"

def find_device
  devices = `xinput`.split("\n").select{|d| d["AB"]}
end

def find_device_sys
  finded = Dir.glob("/sys/**/name").select do |file|
    File.read(file)[BUTTON_NAME]
  end

  "/dev/" + finded.map do |file|
    Dir.glob("#{File.dirname(file)}/**/uevent").map do |file|
      File.read(file).split("\n").select{|s| s['DEVNAME']}.compact.first
    end.compact
  end.flatten.first.split("=")[1]

rescue nil
end

File.open(find_device_sys, 'rb' ) do |input|
  DeviceInput.read_loop(input) do |event|
    if event.type == 'EV_KEY'
      puts event
    end
  end
end

puts find_device_sys


