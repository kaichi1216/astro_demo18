require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  #建立使用者
  let(:user) { create(:user, username: "人造人17號", email: 'robot17@gmail.com', password: '123456') }
  let(:task2) { create(:task, user: user, deadline: Time.now.yesterday, priority: "low") }
  let(:task3) { create(:task, user: user, deadline: Time.now, priority: "middle") }
  before {user}
  scenario "建立新的任務" do
    visit login_path
    fill_in('信箱', with: 'robot17@gmail.com')
    fill_in('密碼', with: '123456')
    click_on "登入"
    visit tasks_path
    click_on "新增任務"
    fill_in('標題', with: "eat")
    select '2019', from: 'task_deadline_1i'
    select '十月', from: 'task_deadline_2i'
    select '24', from: 'task_deadline_3i'
    select '23', from: 'task_deadline_4i'
    select '10', from: 'task_deadline_5i'
    fill_in('內容', with: "eat steak")
    click_on "送出"

    
    expect(page).to have_content "eat"
    expect(page).to have_content "新增任務成功"
    expect(Task.first.task).to eq "eat"
    expect(Task.first.deadline).to eq "2019-10-24 23:10:00.000000000 +0800"
    expect(Task.first.content).to eq "eat steak"

  end


  scenario "建立3個任務後 要依照任務結束時間去排序" do
    visit login_path
    fill_in('信箱', with: 'robot17@gmail.com')
    fill_in('密碼', with: '123456')
    click_on "登入"

    visit tasks_path

    click_on "新增任務"
    fill_in('標題', with: "睡覺")
    select '2019', from: 'task_deadline_1i'
    select '九月', from: 'task_deadline_2i'
    select '24', from: 'task_deadline_3i'
    select '23', from: 'task_deadline_4i'
    select '10', from: 'task_deadline_5i'
    fill_in('內容', with: "上床睡覺")
    click_on "送出"

    click_on "新增任務"
    fill_in('標題', with: "吃到飽")
    select '2019', from: 'task_deadline_1i'
    select '十月', from: 'task_deadline_2i'
    select '24', from: 'task_deadline_3i'
    select '23', from: 'task_deadline_4i'
    select '10', from: 'task_deadline_5i'
    fill_in('內容', with: "吃串燒吃到飽喔")
    click_on "送出"

    click_on "新增任務"
    fill_in('標題', with: "運動")
    select '2019', from: 'task_deadline_1i'
    select '十一月', from: 'task_deadline_2i'
    select '24', from: 'task_deadline_3i'
    select '23', from: 'task_deadline_4i'
    select '10', from: 'task_deadline_5i'
    fill_in('內容', with: "慢跑50圈")
    click_on "送出"
    

    #進到index頁面
    visit tasks_path

    #確認是照任務時間排序
    expect(find('table tbody tr:nth-child(1) td:nth-child(1)')).to have_content("睡覺")
    expect(find('table tbody tr:nth-child(2) td:nth-child(1)')).to have_content("吃到飽")
    expect(find('table tbody tr:nth-child(3) td:nth-child(1)')).to have_content("運動")
  end

  scenario "建立2個任務後 更改狀態" do
    visit login_path
    fill_in('信箱', with: 'robot17@gmail.com')
    fill_in('密碼', with: '123456')
    click_on "登入"

    visit tasks_path
    task2

    

    visit edit_task_url(task2.id)
    select 'processing', from: 'task_state'
    click_on "送出"
    #進到index頁面
    visit tasks_path
    #task2資料的狀態修改後為 processing 
    expect(task2.reload.state).to eq "processing"
  end

  scenario "建立2個任務後 可以點擊等級 任務會以 低 中 高 做排序" do
    visit login_path
    fill_in('信箱', with: 'robot17@gmail.com')
    fill_in('密碼', with: '123456')
    click_on "登入"

    click_on "新增任務"
    fill_in('標題', with: "吃到飽")
    select '2019', from: 'task_deadline_1i'
    select '十月', from: 'task_deadline_2i'
    select '24', from: 'task_deadline_3i'
    select '23', from: 'task_deadline_4i'
    select '10', from: 'task_deadline_5i'
    select 'low', from: 'task_priority'
    fill_in('內容', with: "吃串燒吃到飽喔")
    click_on "送出"

    click_on "新增任務"
    fill_in('標題', with: "吃到飽")
    select '2019', from: 'task_deadline_1i'
    select '十月', from: 'task_deadline_2i'
    select '24', from: 'task_deadline_3i'
    select '23', from: 'task_deadline_4i'
    select '10', from: 'task_deadline_5i'
    select 'middle', from: 'task_priority'
    fill_in('內容', with: "吃串燒吃到飽喔")
    click_on "送出"

    

    visit tasks_path
    click_on "等級"

    #第一筆資料的等級為低 第二筆資料等級為中
    expect(find('table tbody tr:nth-child(1) td:nth-child(5)')).to have_content("中")
    expect(find('table tbody tr:nth-child(2) td:nth-child(5)')).to have_content("低")
  end


end