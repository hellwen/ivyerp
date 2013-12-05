class CustomersController < AuthorizedController
  respond_to :html, :pdf

  def letter
    show!
  end

  # has_many :customer_shippings
  def new_customer_shipping
    if customer_id = params[:id]
      @customer = Customer.find(customer_id)
    else
      @customer = resource_class.new
    end

    @customer_shipping = @customer.customer_shippings.new()
    
    respond_with @customer_shipping
  end

  # has_many :customer_contacts
  def new_customer_contact
    if customer_id = params[:id]
      @customer = Customer.find(customer_id)
    else
      @customer = resource_class.new
    end

    @customer_contact = @customer.customer_contacts.new()

    respond_with @customer_contact
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
