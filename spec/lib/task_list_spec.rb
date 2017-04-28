require_relative "../../lib/task_list"

RSpec.describe TaskList do
  context "about itself" do
    it "has a title" do
      subject = TaskList.new("Example Title")

      expect(subject.title).to eq("Example Title")
    end

    it "has a description" do
      subject = TaskList.new("Example Title", "Example Description")

      expect(subject.description).to eq("Example Description")
    end

    it "equality is based on state" do
      subject = TaskList.new("Example Title", "Example Description")
      other_subject = TaskList.new("Example Title", "Example Description")

      subject.add_task("Example")
      other_subject.add_task("Example")

      expect(subject).to eq(other_subject)
    end
  end

  context "how it relates to tasks" do
    let(:subject) { TaskList.new("Example Task") }

    it "automatically creates Task objects" do
      subject.add_task("Example Task")
      task = subject.tasks.first

      expect(task.title).to eq("Example Task")
      expect(task.id).to eq(0)
    end

    it "can mark a task as completed" do
      subject.add_task("Example Task")
      subject.toggle_completed("0")

      expect(subject.tasks.first.completed?).to be true
    end

    it "tasks can be found by id" do
      subject.add_task("Example 0")
      subject.add_task("Example 1")
      subject.add_task("Example 2")

      expect(subject.find_task_by_id("1").title).to eq("Example 1")
    end

    it "tasks can be deleted" do
      subject.add_task("Task 0")
      subject.delete_task("0")

      expect(subject.tasks).to eq([])
    end

    it "know if any of its tasks have been completed" do
      subject.add_task("Task 0")

      expect(subject.any_completed?).to be_falsy

      subject.toggle_completed("0")

      expect(subject.any_completed?).to be_truthy
    end

    it "know which tasks have been completed" do
      subject.add_task("Task 0")
      subject.add_task("Task 1")
      subject.add_task("Task 2")

      expect(subject.completed_tasks).to eq([])

      subject.toggle_completed("0")

      expect(subject.completed_tasks.size).to eq(1)
      expect(subject.completed_tasks.first.title).to eq("Task 0")
    end

    it "all completed tasks can be deleted" do
      subject.add_task("Task 0")
      subject.add_task("Task 1")
      subject.add_task("Task 2")
      subject.toggle_completed("0")
      subject.toggle_completed("2")

      subject.delete_completed_tasks

      expect(subject.tasks.first.title).to eq("Task 1")
      expect(subject.tasks.size).to eq(1)
    end
  end

end
