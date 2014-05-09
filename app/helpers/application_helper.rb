module ApplicationHelper
  # Redirect the user to anoter URL depending on his session default/main role
  def session_role_redir

  end

  def role_name
    params_role = params['controller'][0...-1]
  end

  def role_icon
    if role_name == 'publisher' then return 'fa-rocket' else return 'fa-bullhorn' end
  end

  def role_actions
    if role_name == 'publisher'
      return [{ :name => 'ConvidarAmigos', :path => 'publishers/invite' }]
    else
      return [{ :name => 'Recomendar', :path => 'advertisers/recommend' }]
    end
  end
end
