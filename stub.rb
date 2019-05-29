require_relative 'task.rb'
include TaskManager

# aFeature = Feature.new(1, "Ruby Interface",
#   "1", "5/24/2019")
# aFeature1 = Feature.new(2, "GUI",
#   "4", "5/24/2019")
# aFeature2 = Feature.new(3, "Manual task adding",
#   "3", "5/24/2019")
#
# aList = List.new
# aList.append(aFeature)
# aList.append(aFeature1)
# aList.append(aFeature2)
# #puts aList["Ruby Interface"].to_s
# #or
# #puts aList[0].to_s
# aWindow = Window.new(aList)
# aWindow.formating

mainController = Controller.new()

mainController.mainMenu()

