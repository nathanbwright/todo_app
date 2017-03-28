require_relative "../../lib/task"

RSpec.describe Task do
  let(:subject) { Task.new("Example Task", 1) }

  it "has a title" do
    expect(subject.title).to eq("Example Task")
  end

  it "has an id" do
    expect(subject.id).to eq(1)
  end

  it "knows that newly created tasks are not complete" do
    expect(subject.completed?).to be false
  end

  it "can be completed and uncompleted" do
    subject.toggle_completed
    expect(subject.completed?).to be true

    subject.toggle_completed
    expect(subject.completed?).to be false
  end

  it "equality is based on state" do
    other_subject = Task.new("Example Task", 1)

    expect(subject).to eq(other_subject)
  end
end
