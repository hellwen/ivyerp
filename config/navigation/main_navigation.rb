# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.autogenerate_item_ids = false

  def account_item(parent, code)
    account = Account.find_by_code(code)
    return unless account

    parent.item "account_#{code}", account.to_s, account_path(account)
  end

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :hr, t('ivyerp.main_navigation.hr'), '#' do |hr|
      hr.item :jobs, t('ivyerp.main_navigation.jobs'), jobs_path
      hr.item :departments, t('ivyerp.main_navigation.departments'), departments_path
      hr.item :employees, t('ivyerp.main_navigation.employees'), employees_path
    end

    # Hack to get engine navigations included
    Ivyerp::Engine.setup_navigation(self, primary)
  end
end
