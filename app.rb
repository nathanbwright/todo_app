require "sinatra"

require_relative "lib/task"
require_relative "lib/task_list"
require_relative "lib/task_list_persistor"

get "/" do
  erb :index
end
