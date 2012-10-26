class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  
  #As long as there is a password_digest column in the database, 
  #adding this one method to our model gives us a secure way to create and authenticate new users.
  has_secure_password
  
  #Use a before_save callback to force Rails to downcase
  #the email attribute before saving the user to the database.
  #Callback is a method that gets invoked at a particular point 
  #in the lifetime of an Active Record object
  before_save { |user| user.email = user.email.downcase }   #alternative -> before_save { self.email.downcase!}
  
  validates :name, presence: true, length: {maximum: 50}  
  #second argument is a hash within a hash
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i    
  #this variable is a constant since it begins with a capital letter
  
  #the same as :presence => true <- which is a hash
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX, on: :create }, 
                    uniqueness: { case_sensitive: false }
  
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
