class DepartmentsController < AuthorizedController
  def index
    @departments = @departments.paginate(:page => params[:page])
  end
end
