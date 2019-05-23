## TaskManager Module written by: Michael Remley
## For use in the CST223 Final Project
module TaskManager
  '''***************************************
  Class:    Task

  Purpose:  Provide an "inteface" for which
            all tasks derive from.
  ***************************************'''
  class Task
    #task constructor
    def initialize(id, item, priority, due)
      @id = id
      @item = item
      @priority = priority
      @due = due
    end

    #Extend the to_s for
    #printing with a given task
    def to_s
      print "Task: ", @item
    end

    def getItem
      @item
    end
  end #End TaskInterface

  '''***************************************
  Class:    Feature

  Purpose:  A type of task

  Use:      Define a feature

  # TODO:   Possible addition of "on click"
            information for a feature
  ***************************************'''
  class Feature < Task
    #class 'constructor'
    def initialize(id, item, priority, due)
      super(id, item, priority, due)
    end

    def to_s
      print "Feature: ", @item
    end
  end #End Feature < TaskInterface

  '''***************************************
  Class:    List

  Purpose:  To Provide list functionality
            for use with the super class
            "Task".
  ***************************************'''
  class List
    #List 'constructor'
    def initialize
      @tasks = Array.new
    end

    #To add a task to the list
    def append(aTask)
      if aTask.kind_of?(Task) #looks for super task
        @tasks.push(aTask)
        self #return self, useful for chain calls
      else
        raise "not a task"
      end
    end

    #remove the first task
    def deleteFirst
      @tasks.shift
    end

    #remove the last task
    def deleteLast
      @tasks.pop
    end

    #overload of the [] operator
    def [](key)
      if key.kind_of?(Integer) #looks for superclass Integer
        result = @tasks[key]
      else #get task by name
        result = @tasks.find { |aTask| key == aTask.getItem }
      end
      return result
    end

    #remove a task with a supplied index
    def deleteAt(index)
      @tasks.delete_at(index)
    end
  end #End class List

  '''***************************************
  Class:    Window

  Purpose:  Provide formating functionality
            to a list of tasks.
  ***************************************'''
  class Window
    #constructor
    def initialize(list)
      if list.kind_of?(List) #looking for a list
        @list = list
      else
        raise "not a list"
      end
    end #End Init
  end #End Window class
end #End Module
