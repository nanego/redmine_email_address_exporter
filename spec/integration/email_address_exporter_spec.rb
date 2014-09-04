require "spec_helper"
# require 'redmine_email_address_exporter/projects_controller_patch'
require File.expand_path('../../../app/overrides/_list', __FILE__)

describe "EmailAddressExporter" do

  it "should see link to modal on /projects page" do
    User.current = User.find(1) # admin
    get "/projects"

    response.should be_success
    assert_select 'a.atom[href=/projects.atom]'
    #TODO: make this test work ; seems deface overrides are not included in test environment (?)
    #assert_select "p.other-formats", :count => 2
  end
end
