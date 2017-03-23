class Task
  attr_accessor :title

  def initialize(title)
    @title = title
    @complete = false
  end

  def complete
    @complete = true
  end

  def completed?
    @complete
  end
end
