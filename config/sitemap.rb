# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://fmhgifts.com"
# Set the path for this sitemap
SitemapGenerator::Sitemap.create do
  add about_path,   :priority => 0.3, :changefreq => 'monthly'
  add submit_path,  :priority => 0.1, :changefreq => 'yearly'
  add privacy_path, :priority => 0.1, :changefreq => 'yearly'

  group(:filename => :categories) do
    Category.find_each do |category|
    add category_path(category), :lastmod => category.updated_at, 
        :priority => 0.9, :changefreq => 'daily'
    end
  end

  group(:filename => :products) do
    Product.find_each do |product|
    add category_product_path(Category.find(product.category_id), product),
    :lastmod => product.updated_at, :priority => 0.7, :changefreq => 'weekly'
    end
  end
end