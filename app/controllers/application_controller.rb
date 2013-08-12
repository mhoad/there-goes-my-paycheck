class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_top_level_categories

  private

    def get_top_level_categories
      @top_level_categories = Category.where(:parent_id => nil) 
    end
  
end
