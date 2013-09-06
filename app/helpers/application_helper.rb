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

  def twitter_cards(card: "summary", title: nil, 
                    description: nil, image: nil)
    render "shared/twitter_card_tags",
      :card => card, :title => title, :description => description,
      :image => image
  end

  def canonical_url
    url_for(:page => params[:page], :only_path => false)
  end

  def analytics_url(source: nil, medium: nil, term: nil, 
                    content: nil, campaign: nil)
    if source.present? && medium.present? && campaign.present?
      tracking_tags = "?utm_source=#{analytics_safe(source)}&utm_medium=#{analytics_safe(medium)}&utm_campaign=#{analytics_safe(campaign)}"
      canonical_url << tracking_tags
    else
      canonical_url
    end
  end

  private
    def analytics_safe(term)
      terms = term.split(" ")
      terms.join("+").html_safe
    end
end
