class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :bookmarks
  has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #属性有效性验证
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\w+@mails.ucas.ac.cn/
  validates(:email,presence: true, length:{maximum:255},format:{with:VALID_EMAIL_REGEX},uniqueness:{case_sensitive:false})
  
  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      nil
    end
  end
  
  #实现动态流原型
  def feed
    following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                      OR user_id = :user_id", user_id: id)
  end
  
  #关注另一个用户
  def follow(other_user)
    following << other_user
  end
    
  #取消关注另一个用户
  def unfollow(other_user)
    following.delete(other_user)
  end
    
  #如果当前用户关注了指定的用户，返回true
  def following?(other_user)
    following.include?(other_user)
  end
end
