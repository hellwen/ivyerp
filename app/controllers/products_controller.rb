class ProductsController < AuthorizedController
  # Scopes
  has_scope :by_text

end
