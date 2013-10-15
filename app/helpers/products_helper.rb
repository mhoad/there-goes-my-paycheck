module ProductsHelper

  def metadata(product)
    set_meta_tags :title => "#{product.category.name}: #{product.name}",
                  :description => product.description[0..160],
                  :og => {
                    :title        => product.name,
                    :type         => 'article',
                    :url          => canonical_url,
                    :description  => product.description,
                    :image        => URI.join(request.url, product.picture.url)
                    },
                  :twitter => {
                    :card         => 'summary',
                    :site         => ENV["TWITTER_SITE"],
                    :creator      => ENV["TWITTER_CREATOR"]
                  }
  end
end
