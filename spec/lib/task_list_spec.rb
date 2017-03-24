require_relative "../../lib/task_list"

RSpec.describe TaskList do
  it "has a title" do
    subject = TaskList.new("Example Title")

    expect(subject.title).to eq("Example Title")
  end

  it "has a description" do
    subject = TaskList.new("Example Title", "Example Description")

    expect(subject.description).to eq("Example Description")
  end

  it "can hold tasks" do
    subject = TaskList.new("Example Title")
    task = instance_double("task")

    subject.add_task(task)
    expect(subject.tasks).to eq([task])
  end
end
