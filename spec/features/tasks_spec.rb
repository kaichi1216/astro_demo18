require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "建立新的任務" do
    visit tasks_path
    click_on "新增任務"
    fill_in('標題', with: "eat")
    select '2014', from: 'task_remenber_created_at_1i'
    select '十月', from: 'task_remenber_created_at_2i'
    select '24', from: 'task_remenber_created_at_3i'
    select '23', from: 'task_remenber_created_at_4i'
    select '10', from: 'task_remenber_created_at_5i'
    fill_in('內容', with: "eat steak")
    click_on "送出"

    
    expect(page).to have_content "eat"
    expect(page).to have_content "新增任務成功"
  end

  #創建三個task
  let(:task2) { create(:task, remenber_created_at: Time.now.yesterday) }
  let(:task3) { create(:task, remenber_created_at: Time.now) }
  let(:task4) { create(:task, remenber_created_at: "2019-10-27 18:48:15 +0800") }

  scenario "建立3個任務後 要依照任務時間去排序" do
    task2
    task3
    task4

    #進到index頁面

    visit tasks_path

    #第一筆資料為 task2 第二筆為 task3 確認是照任務時間排序
    expect(find('table tbody tr:nth-child(1) td:nth-child(1)')).to have_content("task title 1")
    expect(find('table tbody tr:nth-child(2) td:nth-child(1)')).to have_content("task title 2")
    expect(find('table tbody tr:nth-child(3) td:nth-child(1)')).to have_content("task title 3")
  end


end