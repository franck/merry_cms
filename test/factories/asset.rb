Factory.define :asset do |a|
  a.name "an asset"
  a.image_file_name "big_doc.png"
  a.image_content_type "application/msword"
  a.image_file_size "2000"
  a.image_updated_at "#{ Time.now - 2.hours }"
end