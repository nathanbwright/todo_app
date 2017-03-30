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
    task = find_task_by_id(id)
    task.toggle_completed
  end

  def find_task_by_id(id)
    task_id = Integer(id)
    @tasks.detect do |task_obj|
      task = task_obj if task_obj.id == task_id
    end
  end

  def any_completed?
    @tasks.any? { |task| task.completed? }
  end

  def delete_task(id)
    task = find_task_by_id(id)
    @tasks.delete(task)
  end

  def delete_completed_tasks
    @tasks = @tasks.reject do |task|
      task.completed?
    end
  end

  def ==(other)
    other.is_a?(TaskList) &&
      @title == other.title &&
      @description == other.description &&
      @tasks == other.tasks
  end

end
