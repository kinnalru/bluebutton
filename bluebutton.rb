#!/usr/bin/ruby

DEVNAME="AB Shutter3"

def find_device
  devices = `xinput`.split("\n").select{|d| d["AB"]}
end

puts `xinput`.length
puts `xinput`.split("\n").select{|p| p['AB']}
puts "---"


find_device