class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :uid, type: String

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end
end
