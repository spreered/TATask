module TasksHelper
  def deadline_sort
    sort_link(@q, :deadline, t('views.tasks.deadline'), default_order: :desc) 
  end
  def created_sort
    sort_link(@q, :created_at, t('views.tasks.created_at'), default_order: :desc) 
  end
  def priority_sort
    sort_link(@q, :priority, t('views.tasks.priority_t'), default_order: :desc) 
  end
  def state_control(task)
    ctrl_str = ''
    if task.todo?
      ctrl_str +=  ' ' + link_to(t('views.tasks.state.start'), start_task_path, method: :post, class: 'btn btn-outline-primary btn-sm') + ' '
    end
    unless task.completed?
      ctrl_str += ' ' + link_to(t('views.tasks.state.done'), done_task_path, method: :post, class: 'btn btn-outline-primary btn-sm') + ' '
    end
    ctrl_str.html_safe
  end
  def badge_tags(tags)
    tags.map(&:name).map{|tag|"<span class='badge badge-light'>#{tag}</span>"}.join(' ').html_safe
  end
end