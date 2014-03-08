class TaskDecorator < Draper::Decorator
  decorates :task
  delegate_all

  def html_class
  	completion ? 'completed' : 'uncompleted'
  end
end