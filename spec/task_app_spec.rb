require_relative "../task_app"

RSpec.describe TaskApp do

  context "about itself" do
    let(:persistor) { instance_double("TaskListPersistor") }

    it "initialized with a file name and a title" do
      subject = TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor)
      expect(subject.title).to eq("Task App")
    end

    it "can initialize from a file" do
      task_list = TaskList.new("Example Title")
      allow(persistor).to receive(:read).and_return(task_list)

      subject = TaskApp.from_file(file_name: "example_file", persistor: persistor)

      expect(subject.title).to eq("Example Title")
    end

    it "can initialize from an empty file" do
      allow(persistor).to receive(:read).and_return(nil)

      subject = TaskApp.from_file(file_name: "example_file", persistor: persistor)

      expect(subject.title).to eq("TaskApp")
      expect(subject.tasks).to eq([])
    end
  end

  context "information about it's tasks" do
    let(:subject) { TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor) }
    let(:persistor) { spy("TaskListPersistor") }

    before(:each) do
      allow(persistor).to receive(:write)
    end

    it "knows if any tasks have been completed" do
      subject.add_task("Hello World")

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

  end

  context "automatically saves itself in different situations" do
    let(:subject) { TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor) }
    let(:persistor) { spy("TaskListPersistor") }

    before(:each) do
      allow(persistor).to receive(:write)
    end

    it "when a task is added" do
      subject.add_task("Hello World")

      expect(subject.tasks.first.title).to eq("Hello World")
      expect(persistor).to have_received(:write)
    end

    it "when a task is marked as completed" do
      subject.add_task("Hello World")
      subject.toggle_completed("0")

      expect(subject.tasks.first.completed?).to be true
      expect(persistor).to have_received(:write).twice
    end

    it "when a task is deleted" do
      subject.add_task("Hello World")
      subject.delete("0")

      expect(subject.tasks).to eq([])
      expect(persistor).to have_received(:write).twice
    end

    it "when all tasks are deleted" do
      subject.add_task("Hello World")
      subject.toggle_completed("0")

      subject.delete_completed_tasks

      expect(subject.tasks).to eq([])
      expect(persistor).to have_received(:write).thrice
    end
  end
end
