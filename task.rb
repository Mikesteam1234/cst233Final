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
    def getName
      @name
    end

    def getPriority
      @priority
    end

    def getDue
      @dueDate
    end

    def getDescription
      @description
    end
    ####################
  end #End TaskInterface

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
        puts "Select one of the following:\n",
        "1. Add Task\n",
        "2. Remove Task\n",
        "3. Display Tasks\n",
        "4. Exit Program"

        num = gets

        if (num == "1\n")
          addTask()
        end

      end

    end

    def addTask()
      puts "Enter the task name: "
      taskName = gets.chomp

      puts "Enter the priority level (1-10): "
      taskPriority = gets.chomp
      taskPriority.to_i

      #taskPriority.kind_of?(Integer)

      puts "Enter the due date: "
      taskDueDate = gets.chomp

      puts "Enter the description: "
      taskDesc = gets.chomp

      newTask = Task.new(taskName, taskPriority, taskDueDate, taskDesc)
      @taskList.push(newTask)
    end

    @taskList
    @taskCount
  end
  end
