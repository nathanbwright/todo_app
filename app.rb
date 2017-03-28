require "sinatra"
require "haml"

require_relative "./task_app"

TASKS_FILE = "tasks.yaml"

task_app = TaskApp.from_file(file_name: TASKS_FILE)

get "/" do
  haml :index, :locals => {:task_list_title => task_app.title, :task_list => task_app.tasks}
end

post "/new-todo" do
  task_app.add_task(params[:todo])
  redirect back
end

post "/toggle_complete/:id" do
  task_app.toggle_completed(params[:id])
  redirect back
end

post "/delete/:id" do
  task_app.delete(params[:id])
  redirect back
end
