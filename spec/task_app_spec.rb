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
end
