class Task
  attr_accessor :title

  def initialize(title)
    @title = title
    @complete = false
  end

  def done
    @complete = true
  end

  def completed?
    @complete
  end

  def ==(other)
    other.is_a?(Task) &&
      @title == other.title &&
      @complete == other.completed?
  end
end
