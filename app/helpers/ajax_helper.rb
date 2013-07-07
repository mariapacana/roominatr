module AjaxHelper

  def render_partial(partial_name, partial_type, locals)
    partial_name_sym = partial_name.to_sym
    render :json => { partial_name_sym => render_to_string(:partial => partial_type,
                                                           :locals => locals,
                                                           :layout => false)}
  end
end
