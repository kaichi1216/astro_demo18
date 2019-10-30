module TasksHelper

  def task_state(state)
    case state
      when "pending"
        "未處理"
      when "processing"
        "處理中"
      when "solved"
        "已完成"
    end
  end

  def task_priority(priority)
    case priority
    when "low"
      "低"
    when "middle"
      "中"
    when "high"
      "高"
    end
  end

  def state_sort
    if request.GET['sort'] == 'state_desc'
      link_to t('views.tasks.state'), tasks_path(sort: 'state_asc')
    else 
      link_to t('views.tasks.state'), tasks_path(sort: 'state_desc')
    end
  end


  def deadline_sort
    if request.GET['sort'] == 'deadline_desc'
      link_to t('views.tasks.deadline'), tasks_path(sort: 'deadline_asc')
    else 
      link_to t('views.tasks.deadline'), tasks_path(sort: 'deadline_desc')
    end
  end

  def priority_sort
    if request.GET['sort'] == 'priority_desc'
      link_to t('views.tasks.priority'), tasks_path(sort: 'priority_asc')
    else 
      link_to t('views.tasks.priority'), tasks_path(sort: 'priority_desc')
    end
  end
end
