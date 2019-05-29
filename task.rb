## TaskManager Module written by: Michael Remley
## For use in the CST223 Final Project
require 'forwardable.rb'

module TaskManager
  '''***************************************
  Class:    Task

  Purpose:  Provide an "inteface" for which
            all tasks derive from.
  ***************************************'''
  class Task
    #task constructor
    def initialize(name, priority, dueDate, description)
      @name = name
      @priority = priority
      @dueDate = dueDate
      @description = description
    end

    #Extend the to_s for
    #printing with a given task
    def to_s

    end

    ##Getters##########
    def getItem
      @name
    end

    def getId
      @priority
    end

    def getPriority
      @dueDate
    end

    def getDue
      @description
    end
    ####################
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
  Class:    Controller

  Purpose:  Controls the program features such
as the menu, displaying, storing data, etc.

  # TODO:
  ***************************************'''
  class Controller
    #class 'constructor'
    def initialize()
    end

    #start the program
    def fileMenu()

    end

    def mainMenu()
      num = 1

      while (num != "4\n")
        puts "Select one of the following:\n 1. Add Task\n 2. Remove Task\n 3. Display Tasks\n 4. Exit Program"
        num = gets

        if (num == "1\n")
          addTask()
        end

      end

    end

    def addTask()
      puts "Enter the task name: "

      taskName = gets.strip
      taskName = gets.chomp
      puts "Enter the priority: "
      taskPriority = gets.strip
      taskPriority = gets.chomp
      puts "Enter the due date: "
      taskDueDate = gets.strip
      taskDueDate = gets.chomp
      puts "Enter the description: "
      taskDescription = gets.strip
      taskDescription = gets.chomp

      newTask = Task.new(taskName, taskPriority, taskDueDate, taskDescription)
      @taskList[@taskCount] = newTask
      @taskCount = @taskCount + 1
    end

    @taskList = Array.new
    @taskCount = 0
  end #End Feature < TaskInterface

  '''***************************************
  Class:    List

  Purpose:  To Provide list functionality
            for use with the super class
            "Task".
  ***************************************'''
  class List
    #include & Extend
    include Enumerable
    extend Forwardable

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

    #extend of the [] operator
    def [](key)
      if key.kind_of?(Integer) #looks for superclass Integer
        result = @tasks[key]
      else #get task by name
        result = @tasks.find { |aTask| key == aTask.getItem }
      end
      return result
    end

    #extend the each function
    def_delegators :@tasks, :each, :<<

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

    #To format a list of tasks
    def formating
        @list.each do |task|
          print task.getId, " ", task.getItem.ljust(30),
          task.getPriority.rjust(2),
          task.getDue.rjust(10), "\n"
        end
    end
  end #End Window class
end #End Module
