class JobsController < AuthorizedController
  def index
    @jobs = @jobs.paginate(:page => params[:page])
  end
end
