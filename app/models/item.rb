class Item < ActiveRecord::Base
  attr_accessible :active, :item_id, :item_name, :item_order, :item_type
end
