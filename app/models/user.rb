class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :secret_code, optional: true
  belongs_to :role, optional: true

  validates :secret_code_id, presence: {message: "must be valid!"}, if: Proc.new{|k| !(k.admin_user?)}
  validates :secret_code_id, uniqueness: {message: "must be valid!"}, if: Proc.new{|k| k.secret_code_id.present? && !(k.admin_user?)}

  attr_accessor :code

  def code=code
    self.secret_code_id = SecretCode.find_by_code(code).try(:id)
  end

  def role? role_type
    self.role.try(:role_type) == role_type
  end

  def admin_user?
    self.role? 'admin'
  end

end
