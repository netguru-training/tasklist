class ListDecorator < Draper::Decorator
  decorates :list
  delegate_all

  def list_completed_class
    completed ? 'list_completed' : 'list_uncompleted'
  end
end