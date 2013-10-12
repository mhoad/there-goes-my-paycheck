# SitemapGenerator::Sitemap.create do
#   group(:filename => :standard_images) do
#     Product.find_each do |product|
#       @category = Category.friendly.find(product.category_id)
#       @product = @category.products.friendly.find(product.id)
#       add category_product_path(Category.find(product.category_id), product),
#           :images   => [{
#             :loc    => @product.picture.url,
#             :title  => product.name
#             }]
#     end
#   end

#   group(:filename => :feature_images) do
#     Product.find_each do |product|
#       @category = Category.friendly.find(product.category_id)
#       @product = @category.products.friendly.find(product.id)
#       add category_product_path(Category.find(product.category_id), product),
#           :images     => [{
#             :loc      => @product.social_image.url,
#             :title    => product.name,
#             :caption  => product.description
#             }]
#     end
#   end
# end