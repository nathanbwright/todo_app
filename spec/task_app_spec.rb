require_relative "../task_app"

RSpec.describe TaskApp do

  context "about itself" do
    let(:persistor) { instance_double("TaskListPersistor") }

    it "initialized with a file name and a title" do
      task_app = TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor)
      expect(task_app.title).to eq("Task App")
    end

    it "can initialize from a file" do
      task_list = TaskList.new("Example Title")
      allow(persistor).to receive(:read).and_return(task_list)

      task_app = TaskApp.from_file(file_name: "example_file", persistor: persistor)

      expect(task_app.title).to eq("Example Title")
    end

    it "can initialize from an empty file" do
      allow(persistor).to receive(:read).and_return(nil)

      task_app = TaskApp.from_file(file_name: "example_file", persistor: persistor)

      expect(task_app.title).to eq("TaskApp")
      expect(task_app.tasks).to eq([])
    end
  end

  context "information about it's tasks" do
    let(:task_app) { TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor) }
    let(:persistor) { spy("TaskListPersistor") }

    before(:each) do
      allow(persistor).to receive(:write)
    end

    it "knows if any tasks have been completed" do
      task_app.add_task("Hello World")

      expect(task_app.any_completed?).to be_falsy

      task_app.toggle_completed("0")

      expect(task_app.any_completed?).to be_truthy
    end

    it "know which tasks have been completed" do
      task_app.add_task("Task 0")
      task_app.add_task("Task 1")
      task_app.add_task("Task 2")

      expect(task_app.completed_tasks).to eq([])

      task_app.toggle_completed("0")

      expect(task_app.completed_tasks.size).to eq(1)
      expect(task_app.completed_tasks.first.title).to eq("Task 0")
    end

  end

  context "automatically saves itself in different situations" do
    let(:task_app) { TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor) }
    let(:persistor) { spy("TaskListPersistor") }

    before(:each) do
      allow(persistor).to receive(:write)
    end

    it "when a task is added" do
      task_app.add_task("Hello World")

      expect(task_app.tasks.first.title).to eq("Hello World")
      expect(persistor).to have_received(:write)
    end

    it "when a task is marked as completed" do
      task_app.add_task("Hello World")
      task_app.toggle_completed("0")

      expect(task_app.tasks.first.completed?).to be true
      expect(persistor).to have_received(:write).twice
    end

    it "when a task is deleted" do
      task_app.add_task("Hello World")
      task_app.delete("0")

      expect(task_app.tasks).to eq([])
      expect(persistor).to have_received(:write).twice
    end

    it "when all tasks are deleted" do
      task_app.add_task("Hello World")
      task_app.toggle_completed("0")

      task_app.delete_completed_tasks

      expect(task_app.tasks).to eq([])
      expect(persistor).to have_received(:write).thrice
    end
  end
end
