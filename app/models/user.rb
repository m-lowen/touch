class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :contacts, dependent: :destroy
  after_create :send_sign_up_email

  def self.from_omniauth(auth)

    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize
    user.name = auth.info.name
    user.email = auth.info.email

    # unless the user was already created
    unless user.persisted?
      random_password = Devise.friendly_token[0,20]
      user.password = random_password
      user.password_confirmation = random_password
    end
    
    user.save!
    user
  end    


  protected

  def send_sign_up_email
    UserMailer.welcome_email(self).deliver_now
  end
end
