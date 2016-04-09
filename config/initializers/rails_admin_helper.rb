RailsAdmin::ApplicationHelper.class_eval do
  def edit_user_link
    return nil unless _current_user.respond_to?(:email)
    return nil unless abstract_model = RailsAdmin.config(_current_user.class).abstract_model
    return nil unless (edit_action = RailsAdmin::Config::Actions.find(:edit, controller: controller, abstract_model: abstract_model, object: _current_user)).try(:authorized?)
    link_to url_for(action: edit_action.action_name, model_name: abstract_model.to_param, id: _current_user.id, controller: 'rails_admin/main') do
      html = []
      html << content_tag(:span, _current_user.email)
      html.join.html_safe
    end
  end
end
