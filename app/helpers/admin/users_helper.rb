module Admin::UsersHelper
  def identity(role)
    case role
    when "menber"
      t('admin.menber')
    when "admin"
      t('admin.admin')
    end
  end
end
