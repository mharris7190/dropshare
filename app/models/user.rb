class User < ActiveRecord::Base
  validates :name, presence:true, length: { maximum: 50 }
  validates :uid, presence:true
  validates :provider, presence:true
  validates :oauth_token, presence:true
  validates :oauth_expires_at, presence:true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save { email.downcase! }
  
  has_many :groups
  has_many :drop_files
  
  # To track activities for feed page
  include PublicActivity::Model
  tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.oauth_token = auth["credentials"]["token"]
      user.oauth_expires_at = Time.at(auth["credentials"]["expires_at"])
      user.save!
    end
  end
  
  def self.groups
    user.groups = Group.all
  end
end
