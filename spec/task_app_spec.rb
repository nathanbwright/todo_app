require_relative "../task_app"

RSpec.describe TaskApp do

  context "initialization" do
    let(:persistor) { instance_double("TaskListPersistor") }

    it "initialized with a file name and a title" do
      task_app = TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor)
      expect(task_app.title).to eq("Task App")
    end

    it "can initialize from a file" do
      task_list = instance_double("TaskList", :title => "Example Title")
      allow(persistor).to receive(:read).and_return(task_list)

      task_app = TaskApp.from_file(file_name: "example_file", persistor: persistor)

      expect(task_app.title).to eq("Example Title")
    end

    it "can initialize from an empty file" do
      allow(persistor).to receive(:read).and_return(nil)
      task_list = double("TaskList")
      allow(task_list).to receive(:new).and_return(instance_double("TaskList", :tasks => []))

      task_app = TaskApp.from_file(file_name: "example_file", task_list: task_list, persistor: persistor)

      expect(task_app.title).to eq("TaskApp")
      expect(task_app.tasks).to eq([])
    end
  end

  context "delegates responsibility to the both the task_list and the persistor" do
    let(:task_list) { spy("TaskList") }
    let(:persistor) { spy("TaskListPersistor") }
    let(:task_app) { TaskApp.new(title: "Task App", file_name: "file_name", task_list: task_list, persistor: persistor) }

    before(:each) do
      allow(persistor).to receive(:write)
    end

    it "when a task is added" do
      task_app.add_task("Hello World")
      expect(task_list).to have_received(:add_task).with("Hello World")
      expect(persistor).to have_received(:write)

      allow(task_list).to receive(:tasks) { [double(:title => "Hello World")] }
      expect(task_app.tasks.first.title).to eq("Hello World")
    end

    it "when a task is marked as completed" do
      task_app.add_task("Hello World")
      expect(task_list).to have_received(:add_task).with("Hello World")
      expect(persistor).to have_received(:write)

      task_app.toggle_completed("0")
      expect(task_list).to have_received(:toggle_completed).with("0")
      expect(persistor).to have_received(:write).twice

      allow(task_list).to receive(:tasks) { [double(:completed? => true)] }
      expect(task_app.tasks.first.completed?).to be true
    end

    it "when finding completed tasks" do
      task_app.add_task("Task 0")
      task_app.add_task("Task 1")
      task_app.add_task("Task 2")
      expect(task_list).to have_received(:add_task).thrice
      expect(persistor).to have_received(:write).thrice

      allow(task_list).to receive(:completed_tasks) { [] }
      expect(task_app.completed_tasks).to eq([])
      expect(task_list).to have_received(:completed_tasks)

      task_app.toggle_completed("0")
      expect(task_list).to have_received(:toggle_completed).with("0")

      allow(task_list).to receive(:completed_tasks) { [double(:title => "Task 0")] }
      expect(task_app.completed_tasks.size).to eq(1)
      expect(task_app.completed_tasks.first.title).to eq("Task 0")
    end

    it "when a task is deleted" do
      task_app.add_task("Hello World")
      expect(task_list).to have_received(:add_task).with("Hello World")
      expect(persistor).to have_received(:write)

      task_app.delete("0")
      expect(task_list).to have_received(:delete_task).with("0")
      expect(persistor).to have_received(:write).twice

      allow(task_list).to receive(:tasks) { [] }
      expect(task_app.tasks).to eq([])
    end

    it "when all tasks are deleted" do
      task_app.add_task("Hello World")
      expect(task_list).to have_received(:add_task).with("Hello World")
      expect(persistor).to have_received(:write)

      task_app.toggle_completed("0")
      expect(task_list).to have_received(:toggle_completed).with("0")
      expect(persistor).to have_received(:write).twice

      task_app.delete_completed_tasks
      expect(task_list).to have_received(:delete_completed_tasks)
      expect(persistor).to have_received(:write).thrice

      allow(task_list).to receive(:tasks) { [] }
      expect(task_app.tasks).to eq([])
    end
  end
end
