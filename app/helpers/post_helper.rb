module PostHelper
  def rating(post)
    Cache.fetch("post:#{post.id}:rating_helper") do
      "Oceniono na: #{post.rating.round(2)}"
    end
  end

  def visits_count(post)
    Cache.fetch("post:#{post.id}:visits_count_helper", ttl: 120) do
      "Przeczytano już #{post.visits_count} razy"
    end
  end
end
