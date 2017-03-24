require "yaml/store"

class TaskListPersistor
  attr_reader :file_name

  def initialize(file_name, persistor = YAML::Store)
    @file_name = file_name
    @store = persistor.new(@file_name)
  end

  def write(task_list)
    @store.transaction do |s|
      s["list"] = task_list
    end
  end

  def read
    read_only = true
    @store.transaction(read_only) do |s|
      s["list"]
    end
  end

end
