require_relative "lib/task"
require_relative "lib/task_list"
require_relative "lib/task_list_persistor"

class TaskApp
  attr_reader :title

  def self.from_file(file_name:, task_list: TaskList, persistor: TaskListPersistor.new(file_name))
    saved_task_list = persistor.read
    if saved_task_list
      new(title: saved_task_list.title, file_name: file_name, task_list: saved_task_list, persistor: persistor)
    else
      new(title: "TaskApp", file_name: file_name, task_list: task_list.new("TaskApp"), persistor: persistor)
    end
  end

  def initialize(title:, file_name:, task_list: TaskList.new(title), persistor: TaskListPersistor.new(file_name))
    @title = title
    @task_list = task_list
    @persistor = persistor
  end

  def add_task(task)
    @task_list.add_task(task)
    @persistor.write(@task_list)
  end

  def toggle_completed(id)
    @task_list.toggle_completed(id)
    @persistor.write(@task_list)
  end

  def any_completed?
    @task_list.any_completed?
  end

  def delete(id)
    @task_list.delete_task(id)
    @persistor.write(@task_list)
  end

  def delete_completed_tasks
    @task_list.delete_completed_tasks
    @persistor.write(@task_list)
  end

  def tasks
    @task_list.tasks
  end

end
