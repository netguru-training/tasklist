class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  
  field :name, type: String
  field :description, type: String
end
