# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
* 2.6.3
* Rails version
* 5.2.3
* System dependencies

* Configuration

* Database creation 
* pg
* Database initialization
* pg
* How to run the test suite
 
* Services (job queues, cache servers, search engines, etc.)


# 任務管理系統 model 關係圖

<img src="app/assets/images/blog/erm.png">


* Deployment instructions
  Deploy on heroku
  # 步驟1
  註冊 heroku 帳號
  # 步驟2
  安裝 heroku CLI [heroku CLI](https://devcenter.heroku.com/articles/heroku-cli/ "安裝頁面說明")
  # 步驟3
  安裝完成後 在終端機 執行 ```heroku login``` 輸入自己的帳號密碼
  ```
  $ heroku login
  Enter your Heroku credentials.
  Email: aaa@gamil.com
  Password (typing will be hidden):
  Logged in as aaa@gmail.com
  ```
  # 步驟4
  heroku 是使用 Git 部署 所以如果你沒有 GitHub 帳號 請先申請 如果專案有在做版 可直接輸入 ```heroku create``` 沒有版控 先輸入 ```git init``` 
  # 步驟5
  將專案推上 heroku 
  ```
  git push heroku master
  ```
  ## 這邊要注意 因為 heroku 不支援 SQLite  所以我使用 PostgreSQL
  ```
  Verifying deploy.... done.
  ```
  看到這段表示 部署成功囉

  # 步驟6
  執行 ``` heroku run rails db:migrate ```
  這樣初次部署就成功了 

  # 專案更新
  如果專案有更新 執行
  ```
  git add .
  git commit -m "更新名稱"
  git push heroku master
  ```
  # 網站網址
  
* website url: https://kaichi18.herokuapp.com/tasks
