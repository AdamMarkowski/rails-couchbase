Visit.delete_all
Rate.delete_all
Comment.delete_all
Post.delete_all
Author.delete_all

25.times do |i|
  ActiveRecord::Base.transaction do
    puts "#{i+1}/25"
    author = Author.create(
      first_name: Faker::Name.first_name,
      second_name: Faker::Name.last_name
    )
    post = Post.create(
      title: Faker::Book.title,
      body: Faker::Lorem.paragraphs(5).join('<br />'),
      author: author
    )

    Comment.create(
      author: 'Marek',
      body: 'Świetny artykuł!',
      post: post
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

About.create!(
  content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla interdum ipsum ante, a feugiat turpis ullamcorper vel. Praesent at dolor ligula. Quisque molestie urna quam, ac aliquam est dapibus eget. Phasellus et commodo lacus. Aliquam dictum sagittis turpis, id laoreet turpis rhoncus in. Aliquam sodales urna vel cursus tristique. Nam tempor, mauris vitae suscipit malesuada, sapien mauris convallis justo, a luctus lorem metus quis eros.
  Vestibulum non tristique erat, nec tincidunt tellus. Suspendisse vehicula lacus non suscipit aliquet. Sed id malesuada purus, eu sollicitudin massa. Sed interdum urna dolor, aliquam pulvinar massa feugiat sit amet. In ullamcorper diam magna. Suspendisse ornare leo eu magna facilisis commodo. Praesent non dolor vel felis ullamcorper maximus id quis massa. Sed fringilla ligula vitae sem bibendum pretium. Vivamus viverra elit at interdum mollis.
  Curabitur et ipsum id mi cursus mollis a eu lectus. Vestibulum pulvinar est id odio convallis, ac malesuada massa tempus. Pellentesque at dui non nisi consectetur tincidunt id mattis risus. Nulla ultricies sodales hendrerit. Nulla interdum diam sit amet venenatis aliquam. Nam vitae porta justo. Fusce vulputate suscipit nibh in congue. Suspendisse potenti.
  Aliquam volutpat in magna consectetur rhoncus. Nunc eleifend interdum ligula in ornare. Proin varius elit eu nulla efficitur, in efficitur odio aliquet. Donec eros arcu, vulputate sit amet viverra id, consectetur sit amet urna. Sed tempor ante vel elit faucibus sollicitudin. Vestibulum justo mi, fringilla non elit sed, cursus lobortis purus. Aliquam in lobortis nunc, et elementum arcu. Nam in accumsan lacus. Nunc hendrerit pretium sem, quis gravida magna accumsan sed. Integer sollicitudin lacinia sapien non interdum. Sed vitae sodales quam, id ultrices augue. Morbi egestas lectus et volutpat maximus. Sed tempus nunc et enim fermentum sollicitudin.
  Quisque at mattis leo. Praesent ut feugiat arcu. Morbi iaculis porttitor arcu sit amet molestie. Mauris at malesuada sem, a rhoncus augue. Nullam interdum, quam sed scelerisque pharetra, enim purus finibus arcu, vel euismod lectus nunc sit amet nibh. Vestibulum lacinia urna non tincidunt fermentum. Cras nec efficitur nisl. Fusce elementum ante vel urna maximus bibendum.'
)

puts 'Done!'
