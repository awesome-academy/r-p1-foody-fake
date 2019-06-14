require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryBot.create :user}
  subject {user}
  let(:user_invalid) do
    {name: ""}
  end

  context "before action" do
    it { expect(controller).to use_before_action(:find_user) }
    it { expect(controller).to use_before_action(:correct_user) }
    it { expect(controller).to use_before_action(:logged_in_user) }
  end

  describe "GET #new" do
    it "assigns a blank user to the view" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "create valid params" do
      before {post :create, params: {user: FactoryBot.attributes_for(:user)}}
      it "creates a new user" do
        expect(assigns(:user)).to be_a User
      end

      it "redirect after create success" do
        expect(response).to redirect_to(login_path)
      end
    end

    context "create invalid params" do
      before {post :create, params: {user: user_invalid}}
      it "create failure" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before {cookies.permanent.signed[:user_id] = user.id}
    context "update valid params" do
      it "update params name" do
        patch :update, params: {id: subject.id, user: {name: "AAAAAA"}}
        expect(flash[:success]).to match(I18n.t("profile_updated"))
        expect(response).to redirect_to(edit_user_path)
      end
    end

    context "update invalid params" do
      it "update failure" do
        patch :update, params: {id: subject.id, user: {name: ""}}
        expect(response).to render_template :edit
      end
    end
  end
end
