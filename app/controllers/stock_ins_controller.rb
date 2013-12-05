class StockInsController < AuthorizedController
  respond_to :html, :pdf

  def letter
    show!
  end

  # has_many :stock_products
  def new_stock_product
    if stock_id = params[:id]
      @stock = StockIn.find(stock_id)
    else
      @stock = resource_class.new
    end

    @stock_product = @stock.stock_products.new()

    respond_with @stock_product
  end

  def copy
    # Duplicate original Customer
    #original_customer = Customer.find(params[:id])
    #customer = original_customer.copy

    # Override some fields
    #customer.attributes = {}

    # Rebuild positions
    #customer.customer_shippings = original_customer.customer_shippings.map{|line_shipping| line_shipping.copy}
    #set_resource_ivar customer

    #render 'edit'
  end
end
