class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :completion, type: Mongoid::Boolean, default: false
  field :description, type: String

  belongs_to :list

  validates_presence_of :description
end
