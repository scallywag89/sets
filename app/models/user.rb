class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :stack
  has_many :setlists

  validates :email, :first_name, :last_name, :nickname, presence: true
  validates :email, uniqueness: true

  after_create :create_stack

  def create_stack
    Stack.create(user: self)
  end
end
