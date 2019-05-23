require_relative 'task.rb'
include TaskManager

aFeature = Feature.new(1, "Ruby Interface", 1, "Now")
aList = List.new
aList.append(aFeature)
puts aList["Ruby Interface"].to_s
#or
puts aList[0].to_s
aWindow = Window.new(aList)
