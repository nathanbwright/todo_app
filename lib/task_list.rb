class TaskList
  attr_accessor :title, :description
  attr_reader :tasks

  def initialize(title, description = "")
    @title = title
    @description = description
    @tasks = []
  end

  def add_task(task)
    @tasks << task
  end

end
