class TodoItemsController < ApplicationController
  before_action :find_todo_list

  def index
  end

  def new
  	@todo_item = @todo_list.todo_item.new
  end

  def edit
    @todo_item = @todo_list.todo_item.find(params[:id])
  end

  def update
    @todo_item = @todo_list.todo_item.find(params[:id])
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = "Saved todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "That todo item could not be saved."
      render action: :edit
    end
  end

  def complete
    @todo_item = @todo_list.todo_item.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to todo_list_todo_items_path, notice: "Todo item marked as complete."
  end

  def url_options
    { todo_list_id: params[:todo_list_id]}.merge(super)
  end

  def create
  	@todo_item = @todo_list.todo_item.new(todo_item_params)
  	if @todo_item.save
  		flash[:success] = "Added todo list item."
  		redirect_to todo_list_todo_items_path
  	else
  		flash[:error] = "There was a problem adding that todo list item"
  		render action: :new
  	end
  end

  def destroy
    @todo_item = @todo_list.todo_item.find(params[:id])
    if @todo_item.present?
      @todo_item.destroy
    end
    respond_to do |format|
      format.html { redirect_to todo_list_todo_items_path, notice: 'Todo list item was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private 
  def find_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def todo_item_params
  	params[:todo_item].permit(:content)
  end

end
