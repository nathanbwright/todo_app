require_relative "lib/task"
require_relative "lib/task_list"
require_relative "lib/task_list_persistor"

class TaskApp
  attr_reader :title

  def initialize(title:, file_name:, task_list: TaskList.new(title), persistor: TaskListPersistor.new(file_name))
    @title = title
    @task_list = task_list
    @persistor = persistor
  end

  def add_task(task)
    @task_list.add_task(task)
    @persistor.write(@task_list)
  end

  def tasks
    @task_list.tasks
  end

end
