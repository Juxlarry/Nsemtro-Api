class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one_attached :avatar
  has_many :blogs

  validates :name, presence: true, length: {minimum: 3}
  validates :username, presence: true, uniqueness: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true, length: {minimum: 3}
  validates :password, presence: true, length: {minimum: 6}end
 