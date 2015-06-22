class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contacts, dependent: :destroy

  after_create :send_sign_up_email

  protected

  def send_sign_up_email
  	UserMailer.welcome_email(self).deliver_now
  end

end
