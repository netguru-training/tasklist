class Share
  include Mongoid::Document
  belongs_to :user
  belongs_to :list
end
