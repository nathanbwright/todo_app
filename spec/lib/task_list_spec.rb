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

  it "equality is based on state" do
    subject = TaskList.new("Example Title", "Example Description")
    other_subject = TaskList.new("Example Title", "Example Description")
    task = instance_double("task")

    subject.add_task(task)
    other_subject.add_task(task)

    expect(subject).to eq(other_subject)
  end
end
