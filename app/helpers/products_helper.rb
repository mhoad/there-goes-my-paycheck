module ProductsHelper
  require 'addressable/uri'

  def metadata(product)
    set_meta_tags :title => "#{product.category.name}: #{product.name}",
                  :description => product.description[0..160],
                  :og => {
                    :title        => product.name,
                    :type         => 'article',
                    :url          => product.url,
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
