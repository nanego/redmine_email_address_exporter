require_dependency 'projects_controller'

class ProjectsController

  skip_before_filter :find_project, :only => [:get_mail_addresses]
  skip_before_filter :authorize, :only => [:get_mail_addresses]

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

    export = FCSV.generate(:col_sep => ',') do |csv|
      # csv lines
      users = []
      projects.each do |project|
        if options['role'].blank?
          users = users | project.users
        else
          roles = Role.find(options['role'].split(','))
          roles.each do |role|
            users = users | project.users_by_role[role] if project.users_by_role[role]
          end
        end
      end
      csv << users.collect {|u| Redmine::CodesetUtil.from_utf8(u.mail, encoding) }
    end
    export
  end

end
