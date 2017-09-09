puts 'Deleting'
Visit.delete_all
Rate.delete_all
Comment.delete_all
Post.delete_all
Author.delete_all
StaticPage.delete_all

puts 'Creating'

titles = [
  "Wykorzystanie Couchbase'a w aplikacja internetowych",
  'Buforowanie HTTP',
  'Buforowanie fragmentów',
  'Buforowanie widoków',
  'Buforowanie obiektów',
  'Memcached',
  'Consistent hashing',
  'Omówienie Couchbase’a',
  'Główne cechy bazy Couchbase',
  'Wielowymiarowe skalowanie',
  'Przykładowa realizacja Fragment Cache',
  'Przykładowa realizacja Object Cache',
  'Język zapytań N1QL',
  'Indeksy Pełnotekstowe',
  'Wsparcie dla analizy danych'
]

15.times do |i|
  ActiveRecord::Base.transaction do
    puts "#{i+1}/15"
    author = Author.create(
      first_name: Faker::Name.first_name,
      second_name: Faker::Name.last_name
    )
    post = Post.create(
      title: titles.shift,
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

content = %{
The IT Blog to siedmiu autorów piszących na tematy związane z szeroko pojętą branżą IT. Opisujemy, radzimy, recenzujemy narzędzia – wszystko, aby każdego dnia być coraz lepszym.
Zespół tworzą:
Michał Proc (redaktor naczelny)
Paweł Łukaszenko (publicysta)
Cezary Nester (publicysta)
Artiem Wojcieszak (publicystka)
Wojtek Dros (publicysta)
Paulina Wójcik (publicystka)
Agnieszka Mamak (publicystka)
}

StaticPage.create!(
  page: 'about',
  content: content
)

title = "Wykorzystanie Couchbase'a w aplikacja internetowych"
body = %{
  Zasoby obliczeniowe oraz pamięć są ograniczeniem współczesnych aplikacji webowych. W niektórych przypadkach możemy odnieść dużą korzyść efektywnie wykorzystując dobre strategie cache'owania, zmniejszając zużycie pamięci oraz przyśpieszając aplikację.
  Cache'owanie jest powszechnie stosowaną techniką optymalizacji, ponieważ przechowuje ostatnio użyte dane w pamięci, przewidując że będą one potrzebne w przyszłości. Może zostać zaimplementowana na wiele sposobów, włączając rozważne użycie wzorów projektowych.
}

Post.last.update_attributes(title: title, body: body)
Post.last.author.update_attributes(first_name: 'Adam', second_name: 'Markowski')

puts 'Done!'
