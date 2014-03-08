class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :name, type: String
  field :description, type: String

  validates_presence_of :name

  belongs_to :user
  has_many :shares
  has_many :tasks

  def copied_list(user)
    new_list = List.create(self.copy_attributes.merge(user_id: user))
    new_list.tasks = self.copy_tasks
    new_list
  end	
   
  
  def copy_tasks
  	new_tasks = []
  	tasks.each do |task|
      new_tasks << Task.create(task.attributes.slice('completion', 'description'))
  	end
  	new_tasks
  end

  def copy_attributes
  	self.attributes.slice('name', 'description')
  end
end
