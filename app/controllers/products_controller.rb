class ProductsController < AuthorizedController
  # Actions
  def index
    @products = apply_scopes(Product).paginate(:page => params[:page], :per_page => params[:per_page])
    #@products = apply_scopes(Product).accessible_by(current_ability, :list).includes(:name).paginate(:page => params[:page], :per_page => params[:per_page])                                                                      
    index!
  end

end
