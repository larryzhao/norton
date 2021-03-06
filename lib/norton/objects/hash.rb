module Norton
  module Objects
    class Hash
      attr_reader :key, :redis

      def initialize(key, options = {})
        @key   = key
        @redis = Norton.pools[options[:pool_name] || :default]
      end

      # Redis: HSET
      def hset(field, value)
        redis.with { |conn| conn.hset(key, field, value) }
      end
      alias_method :[]=, :hset

      # Redis: HGET
      def hget(field)
        redis.with { |conn| conn.hget(key, field) }
      end
      alias_method :get, :hget
      alias_method :[],  :hget

      # Redis: HMGET
      def hmget(*field)
        redis.with { |conn| conn.hmget(key, field) }
      end
      alias_method :mget, :hmget

      # Redis: HDEL
      def hdel(*field)
        redis.with { |conn| conn.hdel(key, field) }
      end
      alias_method :delete, :hdel

      # Redis: HINCRBY
      def hincrby(field, by = 1)
        redis.with { |conn| conn.hincrby(key, field, by) }
      end
      alias_method :incr, :hincrby

      # Redis: HINCRBY
      def hdecrby(field, by = 1)
        hincrby(field, -by)
      end
      alias_method :decr, :hdecrby

      # Redis: HEXISTS
      def hexists(field)
        redis.with { |conn| conn.hexists(key, field) }
      end
      alias_method :include?, :hexists
      alias_method :has_key?, :hexists
      alias_method :key?,     :hexists
      alias_method :member?,  :hexists

      # Redis: HEXISTS
      def hkeys
        redis.with { |conn| conn.hkeys(key) }
      end
      alias_method :keys, :hkeys

      # Redis: DEL
      def clear
        redis.with { |conn| conn.del(key) }
      end
    end
  end
end
