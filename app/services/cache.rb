require 'libcouchbase'

class Cache

  class << self

    def fetch(key, params = {})
      raise "block hasn't been provided" unless block_given?
      obj = get(key)

      if obj.nil?
        puts "--- key not found: #{key}"
        obj = yield
        set(key, obj, params)
      end

      obj
    end

    def set(key, value, params = {})
      connector_params = {
        format: :marshal
      }.merge(params)
      obj = Marshal.dump(value)
      connector.set(key, obj, connector_params)
    end

    def get(key)
      Marshal.load(
        connector.get(key)
      )
    rescue Libcouchbase::Error::KeyNotFound
      nil
    end

    def remove(key)
      connector.delete(key)
    end

    def flush
      connector.flush
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
