module Dynaru
  class Storage

    def initialize(namespace)
      @namespace = namespace
      Thread.main[@namespace] ||= {}
    end

    def all
      Thread.main[@namespace]
    end

    def get(key)
      Thread.main[@namespace][key]
    end

    def keys
      Thread.main[@namespace].keys
    end

    def set(key, value)
      Thread.main[@namespace][key] = value
    end

    def range(range)
      Thread.main[@namespace].reject {|key, value| !range.include?(key)}
    end

  end
end
