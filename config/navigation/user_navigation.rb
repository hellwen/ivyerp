SimpleNavigation::Configuration.run do |navigation|

  # user navigation
  navigation.items do |primary|
    #primary.item :login, t('sessions.new.title'), '#', :highlights_on => /\/users\/sign_in/, :unless => Proc.new { user_signed_in? }
    primary.item :settings, t('ivyerp.main_navigation.settings'), '#',
                 :if => Proc.new { user_signed_in? } do |settings|
      settings.item :users_settings, t('ivyerp.settings.users.title'), users_path
    end

    #primary.dom_class = 'nav secondary-nav'
  end
end
