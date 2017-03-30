require_relative "../task_app"

RSpec.describe TaskApp do
  it "initialized with a file name and a title" do
    persistor = instance_double("TaskListPersistor")
    subject = TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor)

    expect(subject.title).to eq("Task App")
  end

  it "automatically saves to disk when a task is added" do
    persistor = spy("TaskListPersistor")
    allow(persistor).to receive(:write)

    subject = TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor)

    subject.add_task("Hello World")

    expect(subject.tasks.first.title).to eq("Hello World")
    expect(persistor).to have_received(:write)
  end

  it "automatically saves to disk when a task is marked as completed" do
    persistor = spy("TaskListPersistor")
    allow(persistor).to receive(:write)

    subject = TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor)

    subject.add_task("Hello World")
    subject.toggle_completed("0")

    expect(subject.tasks.first.completed?).to be true
    expect(persistor).to have_received(:write).twice
  end

  it "automatically saves to disk when a task is deleted" do
    persistor = spy("TaskListPersistor")
    allow(persistor).to receive(:write)

    subject = TaskApp.new(title: "Task App", file_name: "file_name", persistor: persistor)

    subject.add_task("Hello World")
    subject.delete("0")

    expect(subject.tasks).to eq([])
    expect(persistor).to have_received(:write).twice
  end

  it "can initialize from a file" do
    persistor = instance_double("TaskListPersistor")
    task_list = TaskList.new("Example Title")
    allow(persistor).to receive(:read).and_return(task_list)

    subject = TaskApp.from_file(file_name: "example_file", persistor: persistor)

    expect(subject.title).to eq("Example Title")
  end

  it "can initialize from an empty file" do
    persistor = instance_double("TaskListPersistor")
    allow(persistor).to receive(:read).and_return(nil)

    subject = TaskApp.from_file(file_name: "example_file", persistor: persistor)

    expect(subject.title).to eq("TaskApp")
    expect(subject.tasks).to eq([])
  end
end
