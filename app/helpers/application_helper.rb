module ApplicationHelper

def require_login
  unless user_signed_in? && current_user.admin?
    flash[:error] = "You must be logged in to access this section"
    redirect_to new_user_session_path # halts request cycle
  end
end

def latest_product(product)
  product.created_at > 30.days.ago
end

end
  