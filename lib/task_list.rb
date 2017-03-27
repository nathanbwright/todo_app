require_relative "./task"

class TaskList
  attr_accessor :title, :description
  attr_reader :tasks

  def initialize(title, description = "")
    @title = title
    @description = description
    @tasks = []
  end

  def add_task(task_title)
    @tasks << Task.new(task_title)
  end

  def ==(other)
    other.is_a?(TaskList) &&
      @title == other.title &&
      @description == other.description &&
      @tasks == other.tasks
  end

end
