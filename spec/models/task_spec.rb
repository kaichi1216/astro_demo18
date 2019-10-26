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

  describe "建立Task 任務內容不能是空白" do 
    it "Task任務內容" do 
      task = Task.create(content: "大家好")
      expect(task.errors.full_messages).to eq ["Task 不能為空白"]
    end
  end
end