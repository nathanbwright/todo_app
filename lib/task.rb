class Task
  attr_accessor :title, :id

  def initialize(title, id)
    @title = title
    @complete = false
    @id = id
  end

  def toggle_completed
    @complete = !@complete
  end

  def completed?
    @complete
  end

  def ==(other)
    other.is_a?(Task) &&
      @title == other.title &&
      @complete == other.completed? &&
      @id == other.id
  end
end
