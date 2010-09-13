module Dynaru
  class Storage

    def initialize(namespace)
      @namespace = namespace
      Thread.main[namespace] ||= {}
    end

    def all(range = nil)
      range ||= (Thread.main[@namespace].keys.min)..(Thread.main[@namespace].keys.max)
      Thread.main[@namespace].reject {|key, value| !range.include?(key)}
    end

    def get(key)
      Thread.main[@namespace]
    end

    def set(key, value)
      Thread.main[@namespace] = value
    end

  end
end
