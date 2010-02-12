#!/usr/bin/env ruby

require 'rubygems'
require 'gcal4ruby'

include GCal4Ruby

service = Service.new
service.authenticate(ENV['GUSER'], ENV['GPASS'])

calendars = service.calendars
# calendars.each { |c| puts c.title }

ld = calendars.find_all { |c| c.title == 'LemoDates' }.first
# puts "#{ld.id} #{ld.title}"

from = Time.now
to   = from + 86400 * 31

# singleevents means recurring events (eg: birthdays) are expanded as standalone events
upcoming = Event.find(ld, '', {:singleevents => true, :range => { :start => from, :end => to }})

puts upcoming.length

upcoming.sort { |x,y| x.start <=> y.end }.each do |e|
  puts "#{e.title} #{e.start.strftime("%d %B")}"
end
