require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "建立Task" do 
    it "新增Task" do 
      task = Task.new
       expect(task).to be_a Task
    end
  end

  describe "建立Task任務跟內容" do 
    it "Task任務內容" do 
      task = Task.new
      task.task = "eat"
      task.content = "eat steak"
       expect(task.task).to eq "eat"
       expect(task.content).to eq "eat steak"
    end
  end
end