# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.autogenerate_item_ids = false

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :hr, t('ivyerp.main_navigation.hr'), '#' do |hr|
      hr.item :employees, t('ivyerp.main_navigation.employees'), employees_path

      hr.item :divider_two, "", :class => 'divider'

      hr.item :jobs, t('ivyerp.main_navigation.jobs'), jobs_path
      hr.item :departments, t('ivyerp.main_navigation.departments'), departments_path
    end

    primary.item :sd, t('ivyerp.main_navigation.sd'), '#' do |sd|
      sd.item :customers, t('ivyerp.main_navigation.customers'), customers_path
    end

    primary.item :mm, t('ivyerp.main_navigation.mm'), '#' do |mm|
      mm.item :products, t('ivyerp.main_navigation.products'), products_path
    end

    primary.item :im, t('ivyerp.main_navigation.im'), '#' do |im|
      im.item :stock_ins, t('ivyerp.main_navigation.stock_ins'), stock_ins_path
      im.item :stock_outs, t('ivyerp.main_navigation.stock_outs'), stock_outs_path

      im.item :divider_two, "", :class => 'divider'

      im.item :inventories, t('ivyerp.main_navigation.inventories'), inventory_stocks_path

      im.item :divider_two, "", :class => 'divider'

      im.item :stock_locations, t('ivyerp.main_navigation.stock_locations'), stock_locations_path
    end

    # Hack to get engine navigations included
    Ivyerp::Engine.setup_navigation(self, primary)
  end
end
