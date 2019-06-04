## TaskManager Module written by: Michael Remley, Levi Leuthold, Dillon Wall
## For use in the CST223 Final Project

require "json"

module TaskManager

  #***************************************
  #           Program constants
  #***************************************

  #Formatting
  TOTAL_LENGTH_OF_WINDOW = 76

  #File I/O
  DEFAULT_FILE = "todo.json"

  #***************************************
  #Class:    Task
  #
  #Purpose:  The class that defines the
  #data members and functionality of a task
  #for use in the program.
  #***************************************
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
      #Not sure if we want this or just use the getters for more
      #selective formatting
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
    #####End Getters#######
    #####Start Setters#####
    def setName(n)
      @name = n
    end

    def setPriority(p)
      @priority = p
    end

    def setDue(due)
      @dueDate = due
    end

    def setDescription(desc)
      @description = desc
    end

    def setId(i)
      @id = i
    end
    ####End Setters#####
  end #End TaskInterface

  #***************************************
  #Class:    Controller
  #
  #Purpose:  Controls the program features such
  #as the menu, displaying, storing data, etc.
  #
  # TODO:
  #****************************************
  class Controller
    #class constructor
    def initialize
      @taskList = Array.new
      @completedList = Array.new
      @taskCount = 0
    end

    #***************************************
    # Method: openFile
    #
    # Purpose: Prompts the user for a file name
    #          or uses the default "todo.json"
    #          and parses and creates both lists
    #          from the JSON file
    #****************************************
    def openFile()
      #Prompt user for file
      print "Enter the file name to open from (Press 'Enter' for default): "
      answer = gets.chomp

      #fix filename
      if (answer == "")
        answer = DEFAULT_FILE
      elsif (!answer.include?(".json"))
        answer.concat(".json")
      end

      #Get the file as a string
      begin
        jFile = File.read(answer)
        if jFile
          data = JSON.parse(jFile)
          @taskList = data['Lists']['TaskList'].map { |task|
            Task.new(task['name'], task['priority'], task['dueDate'],
              task['description'], task['id']) }

          @completedList = data['Lists']['CompletedList'].map { |task|
            Task.new(task['name'], task['priority'], task['dueDate'],
              task['description'], task['id']) }
        else
          #raise what?
          raise "something"
        end #end if

      rescue
        puts "Could not open file '" + answer + "'..."
      end

    end #end open file

    #***************************************
    # Method: displayTasks
    #
    # Purpose: Prompts the user for a file name
    #          or uses the default "todo.json"
    #          and parses both lists and saves them
    #          to the JSON file
    #
    #****************************************
    def saveFile()

      #Prompt user for file
      print "Enter the file name to save to (Press 'Enter' for default): "
      answer = gets.chomp

      #fix filename
      if (answer == "")
        answer = DEFAULT_FILE
      elsif (!answer.include?(".json"))
        answer.concat(".json")
      end

      #Input is valid, try to open file for writing
      begin
        jFile = File.new(answer, "w") #'w' will clear file before writing
        if jFile
          # TASK LIST
          # This hashes the array into a map which is compatible
          # with JSON's generate
          taskList_hash = @taskList.map { |task| {
              name: task.getName, priority: task.getPriority,
              dueDate: task.getDue, description:
              task.getDescription, id: task.getId
          }}
          taskList_json = JSON.pretty_generate(taskList_hash)

          jFile << "{ \"Lists\": \n"
          jFile << "{ \"TaskList\": \n"
          jFile << taskList_json
          jFile << ",\n"

          #COMPLETED LIST
          completedList_hash = @completedList.map { |task| {
              name: task.getName, priority: task.getPriority,
              dueDate: task.getDue, description: task.getDescription,
              id: task.getId
          }}
          completedList_json = JSON.pretty_generate(completedList_hash)

          jFile << "\"CompletedList\": \n"
          jFile << completedList_json
          jFile << "\n"
          jFile << "}\n"
          jFile << "}"

          jFile.close()
        else
          raise
        end
      rescue
        puts "Could not open file '" + answer + "'..."
      end
    end

    #start the program
    def mainMenu
      num = 1

      while (num != "8\n")

        #Clear previous screen
        system "clear" or system "cls"

        print "Select one of the following:\n",
             "-----------ACTIONS----------\n",
             "1. Add Task\n",
             "2. Edit Task\n",
             "3. Complete/Remove Task\n",
             "4. Display All Tasks\n",
             "5. Display Completed Tasks\n",
             "----------FILE I/O----------\n",
             "6. Open list from file\n",
             "7. Save list to file\n",
             "------------Exit------------\n",
             "8. Exit Program\n",
             "----------------------------\n",
             ">> "

        num = gets

        if (num == "1\n")
          #Clear previous screen
          system "clear" or system "cls"
          addTask()
        elsif (num == "2\n")
          editTask(@taskList)
        elsif (num == "3\n")
          #Clear previous screen
          system "clear" or system "cls"
          print "Enter the ID of the task you wish to delete: "
          taskID = gets.chomp
          taskID.to_i
          removeTask(taskID)
        elsif (num == "4\n")
          displayTasks(@taskList)

          print "Press enter to continue..."
          gets

        elsif (num == "5\n")
          displayTasks(@completedList)

          print "Press enter to continue..."
          gets

        elsif (num == "6\n")
          #Clear previous screen
          system "clear" or system "cls"
          openFile()
        elsif (num == "7\n")
          #Clear previous screen
          system "clear" or system "cls"
          saveFile()
        end #end if-elseif

      end

    end

    def addTask()
      print "Enter the task name (10 characters max): "
      taskName = gets.chomp
      while (taskName.length > 10)
        print "Error: Task name cannot exceed 10 characters, re-enter: "
        taskName = gets.chomp
      end

      print "Enter the priority level (1-10): "
      taskPriority = gets.chomp
      taskPriority = taskPriority.to_i
      while (taskPriority < 1 || taskPriority > 10)
        print "Error: The task priority level must be between 1 and 10,",
        " re-enter: "
        taskPriority = gets.chomp
        taskPriority = taskPriority.to_i
      end

      print "Enter the due date in the format of mm/dd/yyyy: "
      taskDueDate = gets.chomp
      while (taskDueDate.length > 10)
        print "Error: Task due date cannot exceed 10 characters make sure it's",
        "in the proper format, re-enter: "
        taskDueDate = gets.chomp
      end

      print "Enter the description: "
      taskDesc = gets.chomp
      while (taskDesc.length > 40)
        print "Error: Task name cannot exceed 40 characters, re-enter: "
        taskDesc = gets.chomp
      end

      newTask = Task.new(taskName, taskPriority, taskDueDate,
        taskDesc, @taskCount)

      @taskList.push(newTask)
      @taskCount = @taskCount + 1
    end

    #***************************************
    # Method: editTask(taskArray)
    #
    # Purpose: A method in which
    #          a user can edit any task
    #          if given the correct id
    #          by the user
    #
    # TODO:
    #*****************************************
    def editTask(taskArray)

      num = 9

      #Clear previous screen
      system "clear" or system "cls"

      #display error message and clear
      #screen on empty tasklist
      if taskArray.length() <= 0
        puts "No tasks to retrieve..."
        print "\nPress enter to continue... "
        gets
        return
      end

      while (num.to_i > 5)

        displayTasks(taskArray)

        print "Select a task to edit (id): "
        choice = gets.chomp

        if !choice.to_i.kind_of?(Integer)
          return
        end

        #Clear previous screen
        system "clear" or system "cls"

        print "Select one of the following:\n",
           "-----------ACTIONS----------\n",
           "1. Edit name\n",
           "2. Edit description\n",
           "3. Edit priority\n",
           "4. Edit due date\n",
           "------------Exit------------\n",
           "5. Exit Program\n",
           "----------------------------\n",
           ">> "

        num = gets.chomp

        if !num.to_i.kind_of?(Integer)
          print "choice was not of type integer...\n",
          "Press enter to continue..."
          gets
          return
        end

        #Clear previous screen
        system "clear" or system "cls"

        if num.to_i == 1

            print "Enter the task name (10 characters max): "
            taskName = gets.chomp
            while (taskName.length > 10)
              print "Error: Task name cannot exceed 10 characters, re-enter: "
              taskName = gets.chomp
            end

            taskArray[choice.to_i].setName(taskName)

        elsif num.to_i == 2

          print "Enter the description: "
          taskDesc = gets.chomp
          while (taskDesc.length > 40)
            print "Error: Task name cannot exceed 40 characters, re-enter: "
            taskDesc = gets.chomp
          end

          taskArray[choice.to_i].setDescription(taskDesc)

        elsif num.to_i == 3

          print "Enter the priority level (1-10): "
          taskPriority = gets.chomp
          taskPriority = taskPriority.to_i
          while (taskPriority < 1 || taskPriority > 10)
            print "Error: The task priority level must be between 1 and 10,",
            " re-enter: "
            taskPriority = gets.chomp
            taskPriority = taskPriority.to_i
          end

          taskArray[choice.to_i].setPriority(taskPriority)

        elsif num.to_i == 4

          print "Enter the due date in the format of mm/dd/yyyy: "
          taskDueDate = gets.chomp
          while (taskDueDate.length > 10)
            print "Error: Task due date cannot exceed 10 characters make sure it's",
            "in the proper format, re-enter: "
            taskDueDate = gets.chomp
          end

          taskArray[choice.to_i].setDue(taskDueDate)

        end #end if-elseif

      end #end while

    end #end editTask()

    #***************************************
    # Method: displayTasks(taskArray)
    #
    # Purpose: A system independant function
    #          used to display a formated
    #          list of all tasks in a given
    #          array
    #
    # TODO:
    #*****************************************
    def displayTasks(taskArray)

      #Clear previous screen
      system "clear" or system "cls"

      #display error message and clear
      #screen on empty tasklist
      if taskArray.length() <= 0
        puts "No tasks to retrieve..."

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

      #Fancy formatting
      puts

      1.upto TOTAL_LENGTH_OF_WINDOW do
        print "-"
      end

      puts

    end #End displayTasks

    def removeTask(taskId)
      index = 0
      found = false
      for task in @taskList do

        #For some reason comparing integers doesn't work here,
        #it only worked when I converted both to strings
        if task.getId().to_s == taskId.to_s
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
end #end module
