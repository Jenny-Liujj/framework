class DashboardPolicy < Struct.new(:user, :dashboard)
  def show?
    user and ( user.role.super_admin? or user.role.admin? )
  end

  AdminModelPrivileges = {
    users: [:super_admin],
    posts: [:super_admin, :admin],
    comments: [:super_admin, :admin]
  }

  AdminModelPrivileges.each do |category, allowed_roles|
    self.class_eval <<-EOT
      def show_#{category}?
        #{allowed_roles.map { |role| "user.role.#{role}?" }.join(' or ')}
      end

      def edit_#{category}?
        #{allowed_roles.map { |role| "user.role.#{role}?" }.join(' or ')}
      end

      def update_#{category}?
        #{allowed_roles.map { |role| "user.role.#{role}?" }.join(' or ')}
      end
    EOT
  end
end
