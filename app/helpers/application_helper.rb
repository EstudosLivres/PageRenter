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
    case role_name
      when 'publisher'
        actions = [
            { :name => t(:publisher_action)[:invite], :path => '#invite', :icon => 'fa fa-paper-plane', :toggle => 'modal' }
        ]
      when 'advertiser'
        actions = [
            { :name => t(:advertiser_action)[:new_campaign], :path => new_campaign_url, :icon => 'fa fa-plus', :toggle => 'modal' },
            { :name => t(:advertiser_action)[:invite], :path => '#recommend', :icon => 'fa fa-paper-plane', :toggle => 'modal' }
        ]
    else
      actions = []
    end

    # Commum actions
    users_actions = [
        { :name => t(:user_action)[:manage_acc], :path => "/#{role_name.pluralize}/edit", :icon => 'fa fa-gears' },
        { :name => t(:user_action)[:feedback], :path => '#feedback', :icon => 'fa fa-comments', :toggle => 'modal' }
    ]

    unless actions.empty?
      users_actions.each do |action|
        actions.append(action)
      end
    end

    actions
  end
end
