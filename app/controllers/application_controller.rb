class ApplicationController < ActionController::Base
  helper_method :current_tool_summary, :current_user, :most_recent_tool
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_tool_summary
    "Tool count: #{current_tool_count}, Tool revenue: #{current_tool_potential_revenue}"
  end

  def current_tool_count
    if Tool.count > 0
      session[:current_tool_count]
    else
      flash[:notice] = "No tools have been created"
    end
  end

  def most_recent_tool
    if session[:most_recent_tool_id]
      Tool.find(session[:most_recent_tool_id])
    else
      flash[:notice] = "No tools created this session"

    end
  end

  def current_tool_potential_revenue
    if Tool.count > 0
      session[:current_tool_potential_revenue]
    else
      flash[:notice] = "No tools have been created"
    end
  end
end
