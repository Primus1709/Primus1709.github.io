class ApplicationController < ActionController::Base
  private

  # The home page is rendered from two places: PagesController#home, and
  # MessagesController#create when the contact form has errors.
  def load_home_page
    @featured_projects = Project.published.featured.ordered.limit(4)
    @featured_projects = Project.published.ordered.limit(4) if @featured_projects.empty?
    @project_count = Project.published.count
  end
end
