class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  before_save :generate_uuid

  field :name, type: String
  field :description, type: String
  field :uuid, type: String

  validates_presence_of :name

  belongs_to :user
  has_many :shares
  has_many :tasks

  def copied_list(user)
    List.create(copy_attributes.merge(user_id: user)).tap do |new_list|
      copy_tasks(new_list)
    end
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
