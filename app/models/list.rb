class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  before_save :generate_uuid

  field :name, type: String
  field :description, type: String
  field :uuid, type: String
  field :completed, type: Mongoid::Boolean, default: false

  validates_presence_of :name

  belongs_to :user
  belongs_to :original, class_name: "#{self.name}", inverse_of: :copies
  has_many :shares
  has_many :tasks
  has_many :copies, class_name: "#{self.name}", inverse_of: :original

  default_scope -> {order_by(created_at: :desc)}

  def copied_list(user)
    new_list = self.class.create(copy_attributes) do |new_list|
      new_list.original = self
      new_list.user = user
      new_list.name = "copy of (#{name})"
    end

    copy_tasks(new_list)
    new_list
  end

  def list_completed
    self.completed = !tasks.where(completion: false).any?
  end

  private
  def copy_tasks(new_list)
    tasks.each do |task|
      task.get_and_copy_task(new_list.id)
    end
  end

  def copy_attributes
    attributes.slice('name', 'description')
  end

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
