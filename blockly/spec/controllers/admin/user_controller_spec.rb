require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  # this lets us inspect the rendered results
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:user) { create :user }

  let(:user_attributes) do
    attributes_for :user
  end

  describe "GET index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should render the expected columns" do
      get :index
      expect(page).to have_content(user.id)
      expect(page).to have_content(user.login_id)
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.role_i18n)
      expect(page).to have_content(user.created_at.strftime("%Y/%m/%d %H:%M"))
      expect(page).to have_content(user.updated_at.strftime("%Y/%m/%d %H:%M"))
    end

    context "filter login_id" do
      let(:filters_sidebar) { page.find('#filters_sidebar_section') }
      let!(:matching_user) { create :user, login_id: 'ABCDEFG' }
      let!(:non_matching_user) { create :user, login_id: 'HIJKLMN' }

      it "exists" do
        get :index
        expect(filters_sidebar).to have_css('label[for="q_login_id"]', text: User.human_attribute_name(:login_id))
        expect(filters_sidebar).to have_css('input[name="q[login_id_contains]"]')
      end

      it "works" do
        get :index, params: { q: { login_id_contains: 'BCDEF' } }
        expect(page).to have_content(matching_user.login_id)
        expect(page).not_to have_content(non_matching_user.login_id)
      end
    end
  end

  describe "GET new" do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should render the form elements" do
      get :new
      expect(page).to have_field( User.human_attribute_name(:login_id) )
      expect(page).to have_field( User.human_attribute_name(:name) )
      expect(page).to have_field( User.human_attribute_name(:role) )
    end
  end

  describe "POST create" do
    it "creates a new User" do
      expect {
        post :create, params: { user: user_attributes }
      }.to change(User, :count).by(1)
    end

    it "redirects to the created user" do
      post :create, params: { user: user_attributes }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_user_path(User.last))
    end

    it 'should create the user' do
      post :create, params: { user: user_attributes }
      user = User.last

      expect(user.login_id).to eq(user_attributes[:login_id])
      expect(user.name).to eq(user_attributes[:name])
      expect(user.role).to eq(user_attributes[:role])
    end
  end

  describe "GET edit" do
    before do
      get :edit, params: { id: user.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "should render the form elements" do
      expect(page).to have_field(User.human_attribute_name(:login_id), with: user.login_id)
      expect(page).to have_field(User.human_attribute_name(:name), with: user.name)
      expect(page).to have_field(User.human_attribute_name(:role), with: user.role)
    end
  end

  describe "PUT update" do
    before do
      put :update, params: { id: user.id, user: user_attributes }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_user_path(user))
    end

    it "should update the user" do
      user.reload
      expect(user.login_id).to eq(user_attributes[:login_id])
      expect(user.name).to eq(user_attributes[:name])
      expect(user.role).to eq(user_attributes[:role])
    end
  end

  describe "GET show" do
    before do
      get :show, params: { id: user.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "should render the form elements" do
      expect(page).to have_content(user.login_id)
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.role_i18n)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested select_option" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the field" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(admin_users_path)
    end
  end
end
