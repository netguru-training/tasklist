class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  
  field :name, type: String
  field :description, type: String

  has_many :tasks

  def copied_list
    new_list = List.create(self.copy_attributes)
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
