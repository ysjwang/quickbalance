module ApplicationHelper

  def stylized_flash(key)
    case key
    when :alert
      "alert-warning"
    when :error
      "alert-danger"
    when :notice
      "alert-info"
    when :success
      "alert-success"
    else
      # "alert-" + key.to_s
      "alert-info" # just use default info for now.
    end
  end


end
