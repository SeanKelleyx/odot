require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe "GET new" do 
    it "renders the new template " do 
      get :new
      expect(response).to render_template('new')
    end
  end
  describe "POST to create" do 
    context "with valid user and email" do
      let(:user){create(:user)}

      it "finds the user" do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        post :create, email: user.email
      end

      it "generates a new password reset token" do 
        expect{ post :create, email: user.email; user.reload}.to change{user.password_reset_token}
      end

      it "sends a password reset email" do
        expect{ post :create, email: user.email; user.reload}.to change(ActionMailer::Base.deliveries, :size)
      end

      it "shows a success message" do 
        post :create, email: user.email
        expect(flash[:notice]).to have_content("Check your email to reset your password.")
      end
    end

    context "with invalid user email" do 
      it "does not find the user" do 
        post :create, email: "none@found.com";
        expect(response).to render_template("new")
      end 
      it "shows error message" do 
        post :create, email: "none@found.com";
        expect(flash[:error]).to have_content("please try again")
      end 
    end
  end
  describe "GET edit" do 
    context "with a valid password_reset_token" do
      let(:user){create(:user)}
      before {user.generate_password_reset_token!}

      it "renders the edit template " do 
        get :edit, id: user.password_reset_token
        expect(response).to render_template('edit')
      end

      it "assigns a user instance variable" do
        get :edit, id: user.password_reset_token
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with no password_reset_token" do
      let(:user){create(:user)}
      before {user.generate_password_reset_token!}

      it "renders the 404 page" do 
        get :edit, id: ""
        expect(response.status).to eq(404)
        expect(response).to render_template(file: "#{Rails.root}/public/404.html")
      end
    end
  end
end
