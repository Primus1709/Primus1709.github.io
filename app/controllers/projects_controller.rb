class ProjectsController < ApplicationController
  def index
    @projects = Project.published.ordered
  end

  def show
    # Unpublished projects are hidden: find_by! raises, and Rails shows a 404
    @project = Project.published.find_by!(slug: params[:id])

    all = Project.published.ordered.to_a
    index = all.index(@project)
    @previous_project = index.positive? ? all[index - 1] : nil
    @next_project = all[index + 1]
  end
end
