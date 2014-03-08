class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :completion, type: Mongoid::Boolean, default: false
  field :description, type: String

  belongs_to :list

  validates_presence_of :description

  def get_and_copy_task(id_list)
    Task.create(attributes.slice('completion', 'description').merge(list_id: id_list))
  end
end
