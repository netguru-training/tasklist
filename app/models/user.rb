class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :uid, type: String

  has_many :lists
  has_many :shares

  def all_lists
    shared = shared_lists.concat(self.lists)
  end

  def all_lists_tagged(tag_list)
    all_lists.select { |list| !(list.tags & tag_list).empty? }
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end

  private

    def shared_lists
      Share.where( user_id: self.id ).map { |share| share.list }
    end
end
