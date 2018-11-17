module TasksHelper
  def deadline_sort
    if request.GET['sort'] == 'deadline_desc'
      link_to t('views.tasks.deadline'), tasks_path(sort: 'deadline_asc')
    else
      link_to t('views.tasks.deadline'), tasks_path(sort: 'deadline_desc')
    end
  end
  def created_sort
    if request.GET['sort'] == 'created_desc'
      link_to t('views.tasks.created_at'), tasks_path(sort: 'created_asc')
    else
      link_to t('views.tasks.created_at'), tasks_path(sort: 'created_desc')
    end
  end
  def priority_sort
    if request.GET['sort'] == 'priority_desc'
      link_to t('views.tasks.priority_t'), tasks_path(sort: 'priority_asc')
    else
      link_to t('views.tasks.priority_t'), tasks_path(sort: 'priority_desc')
    end
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