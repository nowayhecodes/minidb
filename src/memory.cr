module Minidb
  class Memory(K, V)
    class InvalidKey < Exception; end

    struct Entry(V)
      getter value

      def initialize(@value : V); end
    end

    def initialize
      @cache = {} of K => Minidb::Memory::Entry(V)
    end

    def set(key : K, value : V) : V
      @cache[key] = Minidb::Memory::Entry.new(value)
      value
    end

    def get(key : K) : V?
      if entry = @cache[key]?
        entry.value
      else
        raise Minidb::Memory::InvalidKey.new("'#{key.to_s}' is not a valid key")
      end
    end

    def del(key : K) : V?
      if entry = @cache.delete(key)
        entry.value
      else
        raise Minidb::Memory::InvalidKey.new("'#{key.to_s}' is not a valid key")
      end
    end

    def mset(key : K, values : V)
      data = get(key)
      data += values
      set(key, data)
    end

    def length
      @cache.size
    end

    def reset
      @cache = {} of K => Minidb::Memory::Entry(V)
    end

    private def read_entry(key : K) : Minidb::Memory::Entry(V)?
      if entry = @cache[key]?
        entry
      end
    end
  end
end
