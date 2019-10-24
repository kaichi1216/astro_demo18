require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "建立新的任務" do
    FactoryBot.create(:task)

    visit tasks_path

    expect(page).to have_content "task title 1"
  end

  scenario "建立3個任務後 要依照任務時間去排序" do
    #創建三個task
    task2 = FactoryBot.create(:task, remenber_created_at: Time.now.yesterday)
    task3 = FactoryBot.create(:task, remenber_created_at: Time.now)
    task4 = FactoryBot.create(:task, remenber_created_at: "2019-10-27 18:48:15 +0800")
    #進到index頁面
    visit tasks_path

    #印出三個任務時間
    puts task2.remenber_created_at
    puts task3.remenber_created_at
    puts task4.remenber_created_at

    #第一筆資料為 task2 第二筆為 task3 確認是照任務時間排序
    expect(find('table tbody tr:nth-child(1) td:nth-child(1)')).to have_content("task title 2")
    expect(find('table tbody tr:nth-child(2) td:nth-child(1)')).to have_content("task title 3")
  end


end