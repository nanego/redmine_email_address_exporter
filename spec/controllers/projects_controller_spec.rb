require "spec_helper"
require 'redmine_better_crossprojects/projects_controller_patch'
require 'redmine_email_address_exporter/projects_controller_patch'

describe ProjectsController, :type => :controller do

  fixtures :users
  
  render_views

  it "should get_mail_addresses" do
    post :get_mail_addresses, :format => 'csv'
    expect(response).to be_success
  end

  it "should see link to modal on /projects page" do
    User.current = User.find(1) # admin
    get :index
    expect(response).to be_success
    assert_select "a.atom[href='/projects.atom']"
    #TODO: make this test work ; seems deface overrides are not included in test environment (?)
    # assert_select "p.other-formats", :count => 2
  end

end
