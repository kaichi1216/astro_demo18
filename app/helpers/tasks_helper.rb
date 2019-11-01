module TasksHelper

  def task_state(state)
    case state
      when "pending"
        t('state.pending')
      when "processing"
        t('state.processing')
      when "solved"
        t('state.solved')
    end
  end

  def task_priority(priority)
    case priority
    when "low"
      t('helpers.priority_lv.low')
    when "middle"
      t('helpers.priority_lv.middle')
    when "high"
      t('helpers.priority_lv.high')
    end
  end

  def sort_link
    field, sort = params[:sort].to_s.split('_')
    return unless field.in?(%w[state deadline priority])
    return unless sort.in?(%w[asc desc])
    
    link_order = sort === 'desc' ? 'asc' : 'desc'
    link_to t("views.tasks.#{field}"), tasks_path(sort: "#{field}_#{link_order}")
  end

  def state_sort
    if request.params['sort'] == 'state_desc'
      sort_link
    else 
      link_to t('views.tasks.state'), tasks_path(sort: 'state_desc')
    end
  end


  def deadline_sort
    if request.params['sort'] == 'deadline_desc'
      sort_link
    else 
      link_to t('views.tasks.deadline'), tasks_path(sort: 'deadline_desc')
    end
  end

  def priority_sort
    if request.params['sort'] == 'priority_desc'
      sort_link
    else 
      link_to t('views.tasks.priority'), tasks_path(sort: 'priority_desc')
    end
  end
end
