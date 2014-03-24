RedmineApp::Application.routes.draw do
  post "plugin_email_address_exporter_get_mail_addresses", :to => "projects#get_mail_addresses"
end
