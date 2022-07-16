class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_one :stack, dependent: :destroy
  has_many :setlists

  validates :email, :first_name, :last_name, :nickname, presence: true
  validates :email, uniqueness: true

  after_create :create_stack
  after_commit :add_default_avatar, on: [:create]

  private

  def create_stack
    Stack.create(user: self)
  end

  def add_default_avatar
    avatar.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'images', 'sets_logo.svg'
        )
      ), filename: 'default_avatar.svg',
      content_type: 'image/svg+xml'
    )
  end
end
