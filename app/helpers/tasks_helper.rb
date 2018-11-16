module TasksHelper
  def deadline_sort
    if request.GET['sort'] == 'by_deadline_desc'
      link_to t('views.tasks.deadline'), tasks_path(sort: 'by_deadline_asc')
    else
      link_to t('views.tasks.deadline'), tasks_path(sort: 'by_deadline_desc')
    end
  end
  def created_sort
    if request.GET['sort'] == 'by_created_desc'
      link_to t('views.tasks.created_at'), tasks_path(sort: 'by_created_asc')
    else
      link_to t('views.tasks.created_at'), tasks_path(sort: 'by_created_desc')
    end
  end
end
