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

  it "automatically creates Task objects" do
    subject = TaskList.new("Example Title")

    subject.add_task("Example Task")
    expect(subject.tasks.first.title).to eq("Example Task")
  end

  it "equality is based on state" do
    subject = TaskList.new("Example Title", "Example Description")
    other_subject = TaskList.new("Example Title", "Example Description")

    subject.add_task("Example")
    other_subject.add_task("Example")

    expect(subject).to eq(other_subject)
  end
end
