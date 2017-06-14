class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Constants
  #----------------------------------------------------------------------
  MEMBER_TYPE = {admin: 1, app: 2}

  validates :first_name,  	presence: true
  validates :last_name,   	presence: true
  validates :email,   		presence: true
  validates_uniqueness_of :email, case_sensitive: false

  has_many :media, class_name: "Medium", foreign_key: "user_id",   dependent: :destroy

  # Overrides Devise methods
  #----------------------------------------------------------------------
  def password_required?
    member_type == MEMBER_TYPE[:admin] ? super : !super
  end

  # Validation methods
  #----------------------------------------------------------------------
  # Checks user is admin user
  def admin_user?
    user_role == MEMBER_TYPE[:admin]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def api_detail
    {
      id:               id.to_s,
      email:            email,
      first_name:       first_name,
      last_name:        last_name,
      created_time:     created_at.strftime("%Y-%m-%d %H:%M:%S"),
      user_role:        user_role.to_s
    }
  end

  def user_info_detail
    {
      id:               id.to_s,
      full_name:        full_name,
      email:            email,
      member_since:     created_at.strftime("%Y"),
      sign_in_count:    sign_in_count.to_s,
      is_admin:         admin_user? ? "Yes" : "No"
    }
  end
end
