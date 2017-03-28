require_relative "./task"

class TaskList
  attr_accessor :title, :description
  attr_reader :tasks

  def initialize(title, description = "")
    @title = title
    @description = description
    @tasks = []
    @task_count = 0
  end

  def add_task(task_title)
    @tasks << Task.new(task_title, @task_count)
    @task_count += 1
  end

  def toggle_completed(id)
    task_id = Integer(id)
    @tasks[task_id].toggle_completed
  end

  def ==(other)
    other.is_a?(TaskList) &&
      @title == other.title &&
      @description == other.description &&
      @tasks == other.tasks
  end

end
