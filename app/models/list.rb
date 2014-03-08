class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :name, type: String
  field :description, type: String

  has_many :tasks
  belongs_to :user
  has_many :shares
end
