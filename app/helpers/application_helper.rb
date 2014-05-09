module ApplicationHelper
  # Redirect the user to anoter URL depending on his session default/main role
  def session_role_redir

  end

  def role_name
    @params_role = params['controller'][0...-1]
  end

  def role_icon
    if @params_role == 'publisher' then return 'fa-rocket' else return 'fa-bullhorn' end
  end
end
