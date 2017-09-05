require 'libcouchbase'

class Cache

  class << self

    def fetch
      puts 'ok!'
      connector.set(:foo, "world", format: :plain)
      connector.append(:foo, "!")
      connector.prepend(:foo, "Hello, ")
      connector.get(:foo)
    end

    private

    def connector
      bucket = Libcouchbase::Bucket.new(
        hosts: 'couchbase',
        bucket: 'default',
        password: nil
      )
      bucket.quiet = false
      bucket
    end

   end

end
