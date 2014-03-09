class ListDecorator < Draper::Decorator
  decorates :list
  delegate_all

  def list_completed_class
    completed ? 'text-muted' : ''
  end
end