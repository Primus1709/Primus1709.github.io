require "test_helper"

class AdminTest < ActionDispatch::IntegrationTest
  include AdminTestHelpers

  test "admin asks for a password" do
    get admin_projects_path
    assert_response :unauthorized
  end

  test "wrong password is rejected" do
    get admin_projects_path, headers: {
      "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials("admin", "guess")
    }
    assert_response :unauthorized
  end

  test "lists every project, including hidden ones" do
    get admin_projects_path, headers: admin_headers
    assert_response :success
    assert_select "td a", text: "Secret Draft"
  end

  test "adds a project" do
    assert_difference "Project.count", 1 do
      post admin_projects_path, headers: admin_headers,
           params: { project: { title: "New Thing", summary: "It is new.", tech_stack: "Ruby" } }
    end
    assert_redirected_to admin_projects_path
    assert Project.exists?(slug: "new-thing")
  end

  test "shows errors when a project is invalid" do
    post admin_projects_path, headers: admin_headers, params: { project: { title: "", summary: "" } }
    assert_response 422
    assert_select ".form-errors"
  end

  test "updates a project" do
    project = projects(:weather_cli)
    patch admin_project_path(project), headers: admin_headers, params: { project: { featured: "1" } }
    assert_redirected_to admin_projects_path
    assert project.reload.featured?
  end

  test "deletes a project" do
    assert_difference "Project.count", -1 do
      delete admin_project_path(projects(:weather_cli)), headers: admin_headers
    end
  end

  test "opening a message marks it read" do
    message = messages(:recruiter)
    get admin_message_path(message), headers: admin_headers
    assert_response :success
    assert message.reload.read?
  end
end
