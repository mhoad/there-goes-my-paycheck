module ApplicationHelper

  def require_login
    unless user_signed_in? && current_user.admin?
    flash[:error] = "You must be logged in to access this section"
    redirect_to new_user_session_path # halts request cycle
    end
  end

  def get_social_tagline
    tagline = [ "Show us some love already",
                "Tell your friends" ]
    tagline.sample
  end

  def open_graph_tags(title: nil, type: nil, image: nil,
                      url: nil, description: nil)
    render "shared/facebook_open_graph_tags",
      :title => title, :type => type, :image => image,
      :url => url, :description => description
  end

  def twitter_cards(card: nil, title: nil, description: nil, image: nil)
    render "shared/twitter_card_tags",
      :card => card, :title => title, :description => description,
      :image => image
  end
end
