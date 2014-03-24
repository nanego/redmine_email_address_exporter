module RedmineEmailAddressExporter
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context)
      stylesheet_link_tag("email_address_exporter", :plugin => "redmine_email_address_exporter") +
        javascript_include_tag("email_address_exporter", :plugin => "redmine_email_address_exporter")
    end
  end
end
