require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TodoListsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # TodoList. As you add validations to TodoList, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    title: "Hello new title",
    description: "descriprion"
  }}

  let(:invalid_attributes) {{
    title: "H",
    description: "d"
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TodoListsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:user) {create(:user)}

  before do 
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    #context "logged out" do
    # it "requires login" do 
    #    get :index, {}, valid_session
    #    expect(response).to be_redirect
    #    expect(response).to redirect_to(new_user_session_path)
    #  end
    #end
    it "assigns all todo_lists as @todo_lists" do
      todo_list = TodoList.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:todo_lists)).to eq([todo_list])
    end
  end

  describe "GET #show" do
    context "logged in" do
      before do 
        allow(controller).to receive(:require_user).and_return(true)
      end
      it "assigns the requested todo_list as @todo_list" do
        todo_list = TodoList.create! valid_attributes
        get :show, {:id => todo_list.to_param}, valid_session
        expect(assigns(:todo_list)).to eq(todo_list)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new todo_list as @todo_list" do
      get :new, {}, valid_session
      expect(assigns(:todo_list)).to be_a_new(TodoList)
    end
  end

  describe "GET #edit" do
    it "assigns the requested todo_list as @todo_list" do
      todo_list = TodoList.create! valid_attributes
      get :edit, {:id => todo_list.to_param}, valid_session
      expect(assigns(:todo_list)).to eq(todo_list)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TodoList" do
        expect {
          post :create, {:todo_list => valid_attributes}, valid_session
        }.to change(TodoList, :count).by(1)
      end

      it "assigns a newly created todo_list as @todo_list" do
        post :create, {:todo_list => valid_attributes}, valid_session
        expect(assigns(:todo_list)).to be_a(TodoList)
        expect(assigns(:todo_list)).to be_persisted
      end

      it "redirects to the created todo_list" do
        post :create, {:todo_list => valid_attributes}, valid_session
        expect(response).to redirect_to(TodoList.last)
      end

      it "creates todo list for logged in user"  do
        post :create, {:todo_list => valid_attributes}, valid_session
        todo_list = TodoList.last
        expect(todo_list.user).to eq(user)
      end
    end
    context "with invalid params" do
      it "assigns a newly created but unsaved todo_list as @todo_list" do
        post :create, {:todo_list => invalid_attributes}, valid_session
        expect(assigns(:todo_list)).to be_a_new(TodoList)
      end

      it "re-renders the 'new' template" do
        post :create, {:todo_list => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{
        title: "Hello new titleqq",
        description: "descriprion222"
      }}

      it "updates the requested todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => new_attributes}, valid_session
        todo_list.reload
      end

      it "assigns the requested todo_list as @todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
        expect(assigns(:todo_list)).to eq(todo_list)
      end

      it "redirects to the todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
        expect(response).to redirect_to(todo_list)
      end
    end

    context "with invalid params" do
      it "assigns the todo_list as @todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => invalid_attributes}, valid_session
        expect(assigns(:todo_list)).to eq(todo_list)
      end

      it "re-renders the 'edit' template" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested todo_list" do
      todo_list = TodoList.create! valid_attributes
      expect {
        delete :destroy, {:id => todo_list.to_param}, valid_session
      }.to change(TodoList, :count).by(-1)
    end

    it "redirects to the todo_lists list" do
      todo_list = TodoList.create! valid_attributes
      delete :destroy, {:id => todo_list.to_param}, valid_session
      expect(response).to redirect_to(todo_lists_url)
    end
  end

end
