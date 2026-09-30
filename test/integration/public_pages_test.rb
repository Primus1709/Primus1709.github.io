require "test_helper"

class PublicPagesTest < ActionDispatch::IntegrationTest
  test "home page shows featured projects and the contact form" do
    get root_path
    assert_response :success
    assert_select "h1", text: Profile.current[:name]
    assert_select ".work-row__title", text: "Course Tracker"
    assert_select "form.contact-form"
  end

  test "work page lists published projects only" do
    get projects_path
    assert_response :success
    assert_select ".work-row__title", text: "Course Tracker"
    assert_select ".work-row__title", text: "Weather CLI"
    assert_select ".work-row__title", text: "Secret Draft", count: 0
  end

  test "project page shows the case study" do
    get project_path(projects(:course_tracker))
    assert_response :success
    assert_select "h1", text: "Course Tracker"
    assert_select "h2", text: "The problem"
    assert_select ".pager__link--next", text: /Weather CLI/
  end

  test "hidden projects are not found" do
    get project_path(projects(:secret_draft))
    assert_response :not_found
  end

  test "sending a message saves it" do
    assert_difference "Message.count", 1 do
      post messages_path, params: { message: { name: "Jo", email: "jo@example.com", body: "Let's talk about a role." } }
    end
    assert_redirected_to root_path(anchor: "contact")
  end

  test "a message with errors shows them on the home page" do
    assert_no_difference "Message.count" do
      post messages_path, params: { message: { name: "", email: "nope", body: "hi" } }
    end
    assert_response 422
    assert_select ".form-errors"
  end

  test "messages from bots are thrown away" do
    assert_no_difference "Message.count" do
      post messages_path, params: { message: { name: "Bot", email: "bot@example.com", body: "Buy cheap things now!", website: "spam.example" } }
    end
    assert_redirected_to root_path(anchor: "contact")
  end
end
