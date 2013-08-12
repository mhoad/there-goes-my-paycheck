describe "User Pages" do

  subject { page }

  describe "sign up page" do
    before { visit new_user_registration_path }

    it { should have_selector('h2', text: 'Sign up') }
    it { should have_field('user_email') }
    it { should have_field('user_password') }
    it { should have_field('user_password_confirmation') }
    it { should have_button('Sign up') }
  end

  describe "login page" do
    before { visit new_user_session_path }
    it { should have_selector('h2',    text: 'Sign in') }
    it { should have_field('user_email') }
    it { should have_field('user_password') }
    it { should have_button('Sign in') }
  end

  describe "signup" do

    before { visit new_user_registration_path }

    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "error messages" do
        before { click_button submit }

        it { should have_selector('h2', text: 'Sign up') }
        it { should have_content('errors prohibited this user from being saved') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_email",                  with: "user@example.com"
        fill_in "user_password",               with: "foobardeluxe"
        fill_in "user_password_confirmation",  with: "foobardeluxe"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end 
    end
  end

  describe "log out" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    #Need to use the 'click_link' rather than 'visit' because it requires a DELETE request rather than a GET
    before { click_link "Logout" } 

    it { should have_selector('div.alert.alert-success', text: 'Signed out successfully.') }
  end

  describe "edit user" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "correct edit account options shown to normal users" do
     before do
        visit edit_user_registration_path(:user) 
     end
     it { should have_selector('h2', text: 'Edit User') }
     it { should have_css('input#user_email') }
     it { should have_css('input#user_password') }
     it { should have_css('input#user_password_confirmation') }
     it { should have_css('input#user_current_password') }
     it { should have_button('Update') }
    end
  end
end