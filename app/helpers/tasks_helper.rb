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
      t('views.priority_lv.low')
    when "middle"
      t('views.priority_lv.middle')
    when "high"
      t('views.priority_lv.high')
    end
  end

    # 使用方法： sort_link('state'), sort_link('deadline'), sort_link('priority')
  def sort_link(field, default_sort = 'desc')
    # 判斷是否是這三個欄位
    whitelist_field = %w[state deadline priority]
    return unless field.in?(whitelist_field)

    # 將params[:sort]分割成欄位、排序 
    params_field, params_sort = params[:sort].to_s.split('_')
    # 若params的field和要顯示field是相同的話，表示目前依照此field做排序，則顯示目前排序的相反
    if (field == params_field) && params_sort.in?(%w[asc desc])
      link_order = params_sort === 'desc' ? 'asc' : 'desc'
  # 表示沒照此field做排序，給個預設的排序
    else
      link_order = default_sort
    end
    link_to t("views.tasks.#{field}"), tasks_path(sort: "#{field}_#{link_order}")
  end
  # tags用map把每個標籤名字找出來 並給他html css 樣式 最後 加上 html.safe 不然會出現非預期畫面object 
  def render_task_tags(tags)
    tags.map(&:name).map{|tag| "<span class='badge badge-primary'>#{tag}</span>"}.join(' ').html_safe
  end
  #找出所有的Tag
  def all_tags
    Tag.order(:name)
  end
end
