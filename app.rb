require 'sinatra/base'
require 'sinatra/partial'
require "haml"

require_relative "./task_app"


class App < Sinatra::Base
  register Sinatra::Partial

  TASKS_FILE = ARGV.first || "tasks.yaml"

  task_app = TaskApp.from_file(file_name: TASKS_FILE)

  get "/" do
    haml :index, :locals => {:task_app => task_app}
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

  post "/delete_completed" do
    task_app.delete_completed_tasks
    redirect back
  end

  run! if app_file == $0
end
