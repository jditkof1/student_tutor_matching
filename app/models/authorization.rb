class Authorization < ActiveRecord::Base
  belongs_to :user  # should be there already
  validates :provider, :uid, :presence => true
  
  def self.create_with_omniauth(auth, user)
    user.authorizations.create!(provider: auth["provider"], uid: auth["uid"])
  end
  
  def self.exists?(auth_hash)
    #!!(Authorization.find_by(uid: auth_hash['uid'], provider: auth_hash['provider']))
    !!(Authorization.find_with_auth_hash(auth_hash))
  end
  
  def self.find_with_auth_hash(auth_hash)
    Authorization.find_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
  end
end