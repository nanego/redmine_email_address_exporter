require 'redmine'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'redmine_email_address_exporter/hooks'
  require_dependency 'redmine_email_address_exporter/projects_controller_patch'
end

Redmine::Plugin.register :redmine_email_address_exporter do
  name 'Redmine Email Address Exporter plugin'
  author 'Vincent ROBERT'
  description 'This is a plugin for Redmine - It just adds a link on the projects page, so admins can export email addresses per role'
  version '0.0.1'
  requires_redmine_plugin :redmine_base_deface, :version_or_higher => '0.0.1'
  requires_redmine_plugin :redmine_better_crossprojects, :version_or_higher => '0.2'
  requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.4' if Rails.env.test?
  url 'https://github.com/nanego/redmine_email_address_exporter'
  author_url 'mailto:contact@vincent-robert.com'
end
