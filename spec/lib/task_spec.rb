require_relative "../../lib/task"

RSpec.describe Task do
  it "has a title" do
    subject = Task.new("Example Task")

    expect(subject.title).to eq("Example Task")
  end

  it "knows that newly created tasks are not complete" do
    subject = Task.new("Example Task")

    expect(subject.completed?).to be false
  end

  it "can be completed" do
    subject = Task.new("Example Task")

    subject.complete

    expect(subject.completed?).to be true
  end
end
