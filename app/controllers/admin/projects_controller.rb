module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: %i[edit update destroy]

    def index
      @projects = Project.ordered
    end

    def new
      @project = Project.new(year: Date.current.year, position: (Project.maximum(:position) || 0) + 1)
    end

    def create
      @project = Project.new(project_params)

      if @project.save
        redirect_to admin_projects_path, notice: "Added #{@project.title}."
      else
        render :new, status: 422
      end
    end

    def edit
    end

    def update
      if @project.update(project_params)
        redirect_to admin_projects_path, notice: "Saved changes to #{@project.title}."
      else
        render :edit, status: 422
      end
    end

    def destroy
      @project.destroy!
      redirect_to admin_projects_path, notice: "Deleted #{@project.title}.", status: :see_other
    end

    private

    def set_project
      @project = Project.find_by!(slug: params[:id])
    end

    def project_params
      params.require(:project).permit(
        :title, :slug, :summary, :problem, :approach, :outcome, :role, :tech_stack,
        :repo_url, :live_url, :year, :featured, :published, :position
      )
    end
  end
end
