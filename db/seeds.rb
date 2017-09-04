Visit.delete_all
Rate.delete_all
Post.delete_all
Author.delete_all

10.times do |i|
  ActiveRecord::Base.transaction do
    puts "#{i+1}/10"
    author = Author.create(
      first_name: Faker::Name.first_name,
      second_name: Faker::Name.last_name
    )
    post = Post.create(
      title: Faker::Book.title,
      body: Faker::Lorem.paragraphs(4).join("\n"),
      author: author
    )

    Random.rand(10...1000).times do
      Rate.create(
        value: Random.rand(1..5),
        post: post
      )
    end

    Random.rand(1000...2000).times do
      Visit.create(
        ip_addr: Faker::Internet.ip_v4_address,
        post: post
      )
    end
  end
end

puts 'Done!'
