require 'random_data'

50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(

    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

puts "#{Post.count}"
post = Post.find_or_create_by(title: "A unique title", body: "A unique body")
puts "#{Post.count}"

puts "#{Post.count}"
Comment.find_or_create_by(body: "A unique body", post: post)
puts "#{Post.count}"

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"


50.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_paragraph
    price: RandomData.random_paragraph
  )
end
advertisements = Advertisement.all


puts "#{Advertisement.count}"
post = Advertisement.find_or_create_by(title: "A unique title", copy: [text], price: [integer])
puts "#{Advertisement.count}"


puts "Seed finished"
puts "#{Advertisement.count} advertisements created"
