class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :bookmarks
  
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
end
