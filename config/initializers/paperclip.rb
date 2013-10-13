Paperclip.interpolates('category_name') do |attachment, style|
  attachment.instance.category.name.parameterize
end