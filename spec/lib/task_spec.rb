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

    subject.done

    expect(subject.completed?).to be true
  end

  it "equality is based on state" do
    subject = Task.new("Example Title")
    other_subject = Task.new("Example Title")

    expect(subject).to eq(other_subject)
  end
end
