require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "makes a slug from the title when none is given" do
    project = Project.create!(title: "My Cool App!", summary: "Does things.")
    assert_equal "my-cool-app", project.slug
  end

  test "slugs must be unique" do
    project = Project.new(title: "Another", slug: "course-tracker", summary: "Duplicate.")
    assert_not project.valid?
    assert_includes project.errors[:slug], "has already been taken"
  end

  test "requires a title and a summary" do
    project = Project.new
    assert_not project.valid?
    assert project.errors[:title].any?
    assert project.errors[:summary].any?
  end

  test "links must start with http or https" do
    project = projects(:course_tracker)

    project.repo_url = "github.com/me/app"
    assert_not project.valid?

    project.repo_url = "javascript:alert(1)"
    assert_not project.valid?

    project.repo_url = "https://github.com/me/app"
    assert project.valid?
  end

  test "splits the tech stack into a list" do
    project = Project.new(tech_stack: "Java,  Spring Boot , ,PostgreSQL")
    assert_equal ["Java", "Spring Boot", "PostgreSQL"], project.tech_list
  end

  test "uses the slug in URLs" do
    assert_equal "course-tracker", projects(:course_tracker).to_param
  end

  test "published leaves out hidden projects" do
    assert_not_includes Project.published, projects(:secret_draft)
  end
end
