class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  after_save :check_list_completed

  field :completion, type: Mongoid::Boolean, default: false
  field :description, type: String

  belongs_to :list

  validates_presence_of :description

  def get_and_copy_task(id_list)
    Task.create(attributes.slice('completion', 'description').merge(list_id: id_list))
  end

  def check_list_completed
    list.list_completed
    list.save if list.changed?
  end
end
