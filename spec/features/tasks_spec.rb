require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "建立新的任務" do
    visit tasks_path
    click_on "新增任務"
    fill_in('標題', with: "eat")
    select '2014', from: 'task_deadline_1i'
    select '十月', from: 'task_deadline_2i'
    select '24', from: 'task_deadline_3i'
    select '23', from: 'task_deadline_4i'
    select '10', from: 'task_deadline_5i'
    fill_in('內容', with: "eat steak")
    click_on "送出"

    
    expect(page).to have_content "eat"
    expect(page).to have_content "新增任務成功"
    expect(Task.first.task).to eq "eat"
    expect(Task.first.deadline).to eq "2014-10-24 23:10:00.000000000 +0800"
    expect(Task.first.content).to eq "eat steak"

  end

  #創建三個task
  let(:task2) { create(:task, deadline: Time.now.yesterday) }
  let(:task3) { create(:task, deadline: Time.now) }
  let(:task4) { create(:task, deadline: "2019-10-26 18:48:15 +0800") }

  scenario "建立3個任務後 要依照任務結束時間去排序" do
    task2
    task3
    task4

    #進到index頁面
    visit tasks_path

    #第一筆資料為 task4 第二筆為 task2 確認是照任務時間排序
    expect(find('table tbody tr:nth-child(1) td:nth-child(1)')).to have_content("task title 3")
    expect(find('table tbody tr:nth-child(2) td:nth-child(1)')).to have_content("task title 1")
    expect(find('table tbody tr:nth-child(3) td:nth-child(1)')).to have_content("task title 2")
  end

  scenario "建立2個任務後 更改狀態" do
    task2
    task3

    visit edit_task_url(task2.id)
    select 'processing', from: 'task_state'
    click_on "送出"
    #進到index頁面
    visit tasks_path

    #第一筆資料的狀態修改後為 processing 第二筆資料建立時預設值是 pending
    expect(task2.reload.state).to eq "processing"
    expect(task3.state).to eq "pending"
    expect(find('table tbody tr:nth-child(1) td:nth-child(3)')).to have_content("processing")
    expect(find('table tbody tr:nth-child(2) td:nth-child(3)')).to have_content("pending")
  end


end