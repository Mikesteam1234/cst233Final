## TaskManager Module written by: Michael Remley, Levi Leuthold, Dillon Wall
## For use in the CST223 Final Project

module TaskManager
  '***************************************
  Class:    Task

  Purpose:  The class that defines the
  data members and functionality of a task
  for use in the program.
  ***************************************'
  class Task
    #task constructor
    def initialize(name, priority, dueDate, description, id)
      @name = name
      @priority = priority
      @dueDate = dueDate
      @description = description
      @id = id
    end

    #Extend the to_s for
    #printing with a given task
    def toString
      #Not sure if we want this or just use the getters for more selective formatting
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

    def getId
      @id
    end
    ####################
  end #End TaskInterface

  '***************************************
  Class:    Controller

  Purpose:  Controls the program features such
  as the menu, displaying, storing data, etc.

  # TODO:
  ****************************************'
  class Controller
    #class 'constructor'
    def initialize
      @taskList = Array.new
      @taskCount = 0
    end

    #start the program
    def fileMenu

    end

    def mainMenu
      num = 1

      while (num != "4\n")
        puts "Select one of the following:\n",
             "1. Add Task\n",
             "2. Complete/Remove Task\n",
             "3. Display All Tasks\n",
             "4. Exit Program"

        num = gets

        if (num == "1\n")
          addTask()
        elsif (num == "2\n")
          puts "Enter the ID of the task you wish to delete: "
          taskID = gets.chomp
          taskID.to_i
          removeTask(taskID)
        elsif (num == "3\n")
          displayTasks()
        end

      end

    end

    def addTask()
      puts "Enter the task name: "
      taskName = gets.chomp

      puts "Enter the priority level (1-10): "
      taskPriority = gets.chomp
      taskPriority.to_i

      puts "Enter the due date: "
      taskDueDate = gets.chomp

      puts "Enter the description: "
      taskDesc = gets.chomp

      newTask = Task.new(taskName, taskPriority, taskDueDate, taskDesc, @taskCount)
      @taskList.push(newTask)
      @taskCount = @taskCount + 1
    end

    'This method needs some serious formatting'

    def displayTasks()
      puts "\nTasks:\n"
      puts "Name----------Priority----------Due Date----------Description----------"

      for task in @taskList do
        puts "#{task.getName}          #{task.getPriority}          #{task.getDue}           #{task.getDescription}"
        puts ""
      end

    end

    def removeTask(taskId)
      index = 0
      found = false
      for task in @taskList do

        if task.getId().to_s == taskId.to_s   #For some reason comparing integers doesn't work here, it only worked when I converted both to strings
          @taskList.delete_at(index)
          found = true
          break
        end
        index = index + 1
      end

      if (found == false)
        puts "Error: Couldn't find that task to delete."
      end

    end

  end
end
