module TasksHelper
  def deadline_sort
    sort_link(@q, :deadline, t('views.tasks.deadline')) 
  end
  def created_sort
    sort_link(@q, :created_at, t('views.tasks.created_at'), default_order: :desc) 
  end
  def priority_sort
    sort_link(@q, :priority, t('views.tasks.priority_t')) 
  end
  def state_control(task)
    ctrl_str = ''
    if task.todo?
      ctrl_str +=  ' ' + link_to(t('views.tasks.state.start'), start_task_path, method: :post) + ' '
    end
    unless task.completed?
      ctrl_str += ' ' + link_to(t('views.tasks.state.done'), done_task_path, method: :post) + ' '
    end
    ctrl_str.html_safe
  end
end