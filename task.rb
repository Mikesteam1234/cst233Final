## TaskManager Module written by: Michael Remley, Levi Leuthold, Dillon Wall
## For use in the CST223 Final Project

module TaskManager

  '***************************************
             Program constants
  ***************************************'
  #Formatting
  TOTAL_LENGTH_OF_WINDOW = 76

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
    #class constructor
    def initialize
      @taskList = Array.new
      @completedList = Array.new
      @taskCount = 0
    end

    #start the program
    def fileMenu

    end

    def mainMenu
      num = 1

      while (num != "5\n")
        puts "Select one of the following:\n",
             "1. Add Task\n",
             "2. Complete/Remove Task\n",
             "3. Display All Tasks\n",
             "4. Display Completed Tasks\n",
             "5. Exit Program"

        num = gets

        if (num == "1\n")
          addTask()
        elsif (num == "2\n")
          puts "Enter the ID of the task you wish to delete: "
          taskID = gets.chomp
          taskID.to_i
          removeTask(taskID)
        elsif (num == "3\n")
          displayTasks(@taskList)
        elsif (num == "4\n")
          displayTasks(@completedList)
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

    '***************************************
    Class: displayTasks

    Purpose: A system independant function
             used to display a formated
             list of all incomplete tasks

    # TODO: Finish formatting
    ****************************************'
    def displayTasks(taskArray)

      #Clear previous screen
      system "clear" or system "cls"

      #display 'error message' and clear
      #screen on empty tasklist
      if taskArray.length() <= 0
        puts "No tasks to retrieve...\n\n"
        return
      end

      #Display task list header
      print "Id".ljust(4), "Name".ljust(13),
            "Description".ljust(40), "Priority".rjust(8),
            "Due Date".rjust(11), "\n"

      #Fancy formatting
      1.upto TOTAL_LENGTH_OF_WINDOW do
        print "-"
      end

      #for each task in the tasklist -
      #display a formated string readible by
      #the user.
      taskArray.each do |atask|
        print "\n", atask.getId().to_s.ljust(4),
              atask.getName().ljust(10), " | ",
              atask.getDescription().ljust(40),
              atask.getPriority().to_s.rjust(8),
              atask.getDue().rjust(11)
      end #End for each task

      #place holder
      puts

    end #End displayTasks

    def removeTask(taskId)
      index = 0
      found = false
      for task in @taskList do

        if task.getId().to_s == taskId.to_s   #For some reason comparing integers doesn't work here, it only worked when I converted both to strings
          @completedList.push(@taskList.last)
          @taskList.delete_at(index)
          found = true
          break
        end
        index = index + 1
      end

      if (found == false)
        puts "Error: Couldn't find that task to delete."
      else
        @taskCount = @taskCount - 1
      end

    end

  end
end
