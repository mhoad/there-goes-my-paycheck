module CategoriesHelper
  def set_metadata(category, products)
    #Set the default metadata for category pages
    set_meta_tags :title => title_tag(category),
                  :description => category.description[0..160],
                  :og => {
                    :title        => "#{@category.name} Gifts and Products",
                    :type         => 'article',
                    :url          => canonical_url,
                    :description  => category.description,
                    },
                  :twitter => {
                    :card         => 'summary',
                    :site         => ENV["TWITTER_SITE"],
                    :creator      => ENV["TWITTER_CREATOR"]
                  }
    #Set the appropriate pagination values for search engines if required             
    set_meta_tags :next => products.next_page if products.next_page
    set_meta_tags :prev => products.previous_page if products.previous_page
  end

  private
    def title_tag(category) 
      return category.name if category.parent_category.nil?
      return "#{category.name} - #{category.parent_category.name}"
    end
end