require 'redmine'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'redmine_email_address_exporter/hooks'
  require_dependency 'redmine_email_address_exporter/projects_controller_patch'
end

# Little hack for using the 'deface' gem in redmine:
# - redmine plugins are not railties nor engines, so deface overrides in app/overrides/ are not detected automatically
# - deface doesn't support direct loading anymore ; it unloads everything at boot so that reload in dev works
# - hack consists in adding "app/overrides" path of the plugin in Redmine's main #paths
Rails.application.paths["app/overrides"] ||= []
Rails.application.paths["app/overrides"] << File.expand_path("../app/overrides", __FILE__)

Redmine::Plugin.register :redmine_email_address_exporter do
  name 'Redmine Email Address Exporter plugin'
  author 'Vincent ROBERT'
  description 'This is a plugin for Redmine - It just adds a link on the projects page, so admins can export email addresses per role'
  version '0.0.1'
  requires_redmine_plugin :redmine_base_select2, :version_or_higher => '0.0.1'
  requires_redmine_plugin :redmine_better_crossprojects, :version_or_higher => '0.2'
  url 'https://github.com/nanego/redmine_email_address_exporter'
  author_url 'mailto:contact@vincent-robert.com'
end
