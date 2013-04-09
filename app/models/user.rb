class User < ActiveRecord::Base
  has_secure_password

  has_one  :profile
  has_many :projects

  attr_accessible :email, :password, :password_confirmation

  validates :email,
            :presence   => true,
            :format     => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
            :uniqueness => true

  validates :password,
            :presence => true,
            :length => {:minimum => 8}

  validates :password,
            :confirmation => true,
            :on           => :create

  # Authenticate a user by a passed email and password.
  #
  # Returns: self, or false if authentication fails
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

end
