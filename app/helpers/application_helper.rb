module ApplicationHelper
  # Redirect the user to anoter URL depending on his session default/main role
  def session_role_redir

  end

  def role_name
    # Remove the pluralize
    params['controller'][0...-1]
  end

  def role_icon
    if role_name == 'publisher' then return 'fa-rocket' else return 'fa-bullhorn' end
  end

  def role_actions
    if role_name == 'publisher'
      actions = [
          { :name => t(:publisher_action)[:invite], :path => 'publishers/invite', :icon => 'fa fa-paper-plane' }
      ]
    elsif role_name == 'advertiser'
      actions = [
          { :name => t(:advertiser_action)[:invite], :path => 'advertisers/recommend', :icon => 'fa fa-paper-plane' }
      ]
    else
      actions = []
    end

    # Commum actions
    users_actions = [
        { :name => t(:user_action)[:feeedback], :path => 'publishers/invite', :icon => 'fa fa-comments' }
    ]

    users_actions.each do |action|
      actions.append(action)
    end

    actions
  end
end
