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
      when 'admin'
        return 'fa-user'
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

  # Build the arrays of actions for the user menu
  def role_actions
    # Publisher action_menu
    new_social_session = { name: t(:publisher_action)[:new_social_session], path:add_social_login_path, icon:'fa fa-plus', toggle:'' }
    publisher_invite = { name:t(:publisher_action)[:invite], path:'#invite', icon:'fa fa-paper-plane', toggle:'modal' }

    # Advertiser action_menu
    new_campaign = { name:t(:advertiser_action)[:new_campaign], path:new_campaign_url, icon:'fa fa-plus', toggle:'modal' }
    recommend = { name:t(:advertiser_action)[:invite], path:'#recommend', icon:'fa fa-paper-plane', toggle:'modal' }

    # Admin action_menu
    new_segmentation = {name:'NovoSegmento', path:new_segment_path, icon:'fa fa-plus', toggle:''}
    edit_segmentation = {name:'GerenciarSegmentos', path:segments_path, icon:'fa fa-sitemap', toggle:''}
    base_segmentation = {name:'Segmentos', path:'#segments', icon:'fa pie_chart', toggle:'dropdown'}
    segmentation = [base_segmentation, new_segmentation, edit_segmentation]
    analyse_ads = {name:'AnalisarAnúncios', path:admin_ad_analyse_path, icon:'fa fa-check-square-o', toggle:''}

    # Universal User action_menu
    manage_acc = { name:t(:user_action)[:manage_acc], path:"/#{role_name.pluralize}/edit", icon:'fa fa-gears' }
    api = { name:'API', path:'/api/console/docs', icon:'fa fa-cubes' }
    feedback = { name:t(:user_action)[:feedback], path:'#feedback', icon:'fa fa-comments', toggle:'modal' }

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
      when 'admin'
        actions = [
          segmentation,
          analyse_ads
        ]
    else
      actions = []
    end

    # Commum actions
    users_actions = [
        feedback
        # manage_acc,
        # api TODO volta quando tiver a parte de Marketplace e Blogs
    ] # Modals first because user can click without redirect if click accidentally

    unless actions.empty?
      users_actions.each do |action|
        actions.append(action)
      end
    end

    actions
  end

  def format_date(date)
    return if date.nil?
    date.strftime("%d/%m/%Y")
  end

  # Translate hardcoded attrs
  def translate_attr(model, attr_name)
    I18n.t("db_enum.#{model}.#{attr_name}")
  end

  # Translate a label passing it name
  def translate_it_label(model_name, label_name)
    I18n.t("activerecord.attributes.#{model_name}.labels.#{label_name}")
  end

  # Translate a model name
  def translate_it_model(model_name)
    I18n.t("activerecord.models.#{model_name}")
  end
end
