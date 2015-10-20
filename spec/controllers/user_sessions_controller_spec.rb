require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  let!(:user) {User.create(first_name: "name", last_name: "last", email: "name@domain.com", password: "password123", password_confirmation: "password123")}

  def post_to_create
    post :create, email: "name@domain.com", password: "password123"
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do 
      get "new"
      expect(response).to render_template("new")
    end

  end

  describe "POST #create" do
    context "With correct credentials" do 
      it "redirects to the todo_list path" do
        post_to_create
        expect(response).to be_redirect
        expect(response).to redirect_to todo_lists_path
      end

      it "finds the user" do 
        expect(User).to receive(:find_by).with({email: "name@domain.com"}).and_return(user)  
        post_to_create
      end

      it "authenticate the user" do   
        allow(User).to receive(:find_by).and_return(user)     
        expect(user).to receive(:authenticate)
        post_to_create
      end

      it "sets the user id in the session" do 
        post_to_create
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets flash with success message" do 
        post_to_create
        expect(flash[:success]).to eq("Thank you for logging in!")
      end

      it "sets the session User_id to the created user" do
        post_to_create
        expect(session[:user_id]).to eq(User.find_by(email: "name@domain.com").id)
      end
    end

    shared_examples_for "denied login" do 
      it "renders the new template" do
        post :create, email: email, password: password
        expect(response).to render_template("new")
      end

      it "sets flash with success message" do 
        post :create, email: email, password: password
        expect(flash[:error]).to eq("There was a problem logging in. Please check your email and password.")
      end
    end

    context "With blank credentials" do 
      let!(:email) { "" }
      let!(:password) { "" }
      it_behaves_like "denied login"      
    end

    context "With incorrect password" do 
      let!(:email) { user.email }
      let!(:password) { user.password + "12" }
      it_behaves_like "denied login"
    end

    context "With incorrect password" do 
      let!(:email) { "usernot@found.com" }
      let!(:password) { user.password }
      it_behaves_like "denied login"
    end

  end

end
