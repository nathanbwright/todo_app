require "tempfile"

require_relative "../../lib/task_list"
require_relative "../../lib/task_list_persistor"

RSpec.describe TaskListPersistor do
  it "has a filename" do
    subject = TaskListPersistor.new("example.something")

    expect(subject.file_name).to eq("example.something")
  end

  it "can persist a TaskList" do
    Tempfile.open("example") do |file|
      task_list = TaskList.new("Example Title")
      subject = TaskListPersistor.new(file)

      subject.write(task_list)

      expect(subject.read).to eq(task_list)
    end
  end

end
