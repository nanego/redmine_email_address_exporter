require_dependency 'projects_controller'

class ProjectsController

  skip_before_action :find_project, :only => [:get_mail_addresses]
  skip_before_action :authorize, :only => [:get_mail_addresses]

  def get_mail_addresses
    retrieve_project_query
    @projects = @query.projects
    remove_hidden_projects
    if params['role'].present?
      filename = "emails-#{Role.find(params['role']).join("-")}.csv"
    else
      filename = "emails.csv"
    end
    send_data query_to_mail_addresses(@projects, params), :type => 'text/csv; header=present', :filename => filename
  end

  def query_to_mail_addresses(projects, options={})
    encoding = l(:general_csv_encoding)

    all_users = []
    projects.each do |project|
      if options['role'].blank?
        all_users = all_users | project.users
      else
        roles = Role.find(options['role'].split(','))
        roles.each do |role|
          all_users = all_users | project.users_by_role[role] if project.users_by_role[role]
        end
      end
    end
    all_users.sort! { |a,b| a.lastname.downcase <=> b.lastname.downcase }

    Redmine::Export::CSV.generate do |csv|
      # csv lines
      all_users.in_groups_of(50, false).each do |group|  # TODO make it customizable in plugin settings
        # csv line
        csv << group.collect {|u| Redmine::CodesetUtil.from_utf8(u.mail, encoding) }
      end
    end
  end

end
