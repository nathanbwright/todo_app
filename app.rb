require "sinatra"
require "haml"

require_relative "lib/task"
require_relative "lib/task_list"
require_relative "lib/task_list_persistor"

get "/" do
  haml :index, :locals => {:foo => "hello"}
end

post "/new-todo" do
  @task =  params[:todo]
  "This is what you entered #{@task}"
end
