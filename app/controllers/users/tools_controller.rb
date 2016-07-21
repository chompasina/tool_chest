class Users::ToolsController < ApplicationController
before_action :require_login

  def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to login_path # halts request cycle
    end
  end

  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def new
    require "pry"; binding.pry
    #need to create a new empty tool object for form for to refer to
    @tool = Tool.new
  end

  def create
    session[:current_tool_potential_revenue] = 0 if session[:current_tool_potential_revenue].nil?
    session[:current_tool_potential_revenue] = 0 if session[:current_tool_potential_revenue].nil?
      @tool = Tool.new(tool_params)
    #was tool = Tool.new(params[:tool]) until added private method below
    if @tool.save
      session[:most_recent_tool_id] = @tool.id
      flash[:notice] = "#{@tool.name} was created!"
      session[:current_tool_potential_revenue] = @tool.price + session[:current_tool_potential_revenue].to_i
      session[:current_tool_count] = @tool.quantity + session[:current_tool_count].to_i
      # byebug
      redirect_to tools_path
    else
      # byebug
      flash[:error] = "#{@tool.errors.full_messages.join(", ")}"
      render :new
      #would go here if some of the validations failed and/or couldn't create the tool
    end
  end



  def edit
    #similar to new in that it's a get request and uses a form
    @tool = Tool.find(params[:id])
  end

  def update
    tool = Tool.find(params[:id])

    if tool.update(tool_params)
      redirect_to tools_path
      # tool_path(tool.id)
    else
      render :edit
    end
  end

  def destroy
    tool = Tool.find(params[:id])
    tool.delete
    session[:most_recent_tool_id] = Tool.last.id
    redirect_to tools_path
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :quantity, :price)
    #allows this info to come through with name, quantity, and price, only with tool params. that's all we'll accept in our html.
  end
  end
