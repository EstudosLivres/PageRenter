module ApplicationHelper
  def role_name
    # Remove the pluralize
    url_role = request.fullpath.split(/\//)[1]
    url_role[0...-1]
  end

  def role_icon role_param=''
    case role_param
      when 'publisher'
        return 'fa-rocket'
      when 'advertiser'
        return 'fa-bullhorn'
    end

    case role_name
      when 'publisher'
        return 'fa-rocket'
      when 'advertiser'
        return 'fa-bullhorn'
      else
        if role_param.length >= 3 then return role_param end
        return 'fa-error'
    end
  end

  # Dynamic choose 'default' button: (primary for adv & success for publisher).
  def current_button
    if role_name == 'publisher' then return 'btn-success' else return 'btn-primary' end
  end

  def role_actions
    # Publisher action_menu
    new_social_session = { :name => t(:publisher_action)[:new_social_session], :path => '#new_social_session', :icon => 'fa fa-plus', :toggle => 'modal' }
    publisher_invite = { :name => t(:publisher_action)[:invite], :path => '#invite', :icon => 'fa fa-paper-plane', :toggle => 'modal' }

    # Advertiser action_menu
    new_campaign = { :name => t(:advertiser_action)[:new_campaign], :path => new_campaign_url, :icon => 'fa fa-plus', :toggle => 'modal' }
    recommend = { :name => t(:advertiser_action)[:invite], :path => '#recommend', :icon => 'fa fa-paper-plane', :toggle => 'modal' }

    # Universal User action_menu
    manage_acc = { :name => t(:user_action)[:manage_acc], :path => "/#{role_name.pluralize}/edit", :icon => 'fa fa-gears' }
    api = { :name => 'API', :path => '/api/console/docs', :icon => 'fa fa-cubes' }
    feedback = { :name => t(:user_action)[:feedback], :path => '#feedback', :icon => 'fa fa-comments', :toggle => 'modal' }

    case role_name
      when 'publisher'
        actions = [
            new_social_session,
            publisher_invite
        ]
      when 'advertiser'
        actions = [
            new_campaign,
            recommend
        ]
    else
      actions = []
    end

    # Commum actions
    users_actions = [
        feedback,
        manage_acc,
        api
    ] # Modals first because user can click without redirect if click accidentally

    unless actions.empty?
      users_actions.each do |action|
        actions.append(action)
      end
    end

    actions
  end
end
