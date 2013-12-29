# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :authentication_keys => [:login]

  def attr_list
    [:username, :email, :role_t_texts, :employee]
  end

  # API
  #devise :token_authenticatable
  #before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :login,  :employee_id
  validates_presence_of :username, :employee_id
  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  belongs_to :employee

  # Authorization roles
  has_and_belongs_to_many :roles, :autosave => true

  scope :by_role, lambda{|role| include(:roles).where(:name => role)}
  attr_accessible :role_texts

  def role?(role)
    !!self.roles.find_by_name(role.to_s)
  end

  def role_texts
    roles.map{|role| role.name}
  end

  def role_t_texts
    roles.map{|role| I18n.translate(role.name, :scope => 'cancan.roles')}
  end

  def role_texts=(role_names)
    self.roles = Role.where(:name => role_names)
  end

  # Locale
  attr_accessible :locale

  # Helpers
  def to_s
    if employee.blank?
      username.present? ? username : ''
    else
      employee.present? ? employee : ''
    end
  end
end
