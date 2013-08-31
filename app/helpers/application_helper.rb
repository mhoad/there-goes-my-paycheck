module ApplicationHelper

def require_login
  unless user_signed_in? && current_user.admin?
    flash[:error] = "You must be logged in to access this section"
    redirect_to new_user_session_path # halts request cycle
  end
end

def get_product_tags(product)
  product_tags = "all "
  product_tags << "premium "  if is_expensive_product?(product)
  product_tags << "cheap "    if is_cheap_product?(product)
  product_tags << "latest "   if is_latest_product?(product)
  return product_tags.strip
end

private

  def is_latest_product?(product)
    product.created_at > 30.days.ago
  end

  def is_expensive_product?(product)

    if product.price.nil?
      return false 
    else
      return true if product.price >= 100
    end
  end

  def is_cheap_product?(product)
    if product.price.nil?
      return false 
    else
      return true if product.price < 100
    end
  end

end
  