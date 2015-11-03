class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, 
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_many :bookmarks

  has_many :identities

end