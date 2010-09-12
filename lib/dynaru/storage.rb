module Dynaru
  class Storage

    def initialize(namespace)
      @namespace = namespace
      Thread.main[namespace] ||= {}
    end

    def [](key)
      Thread.main[@namespace]
    end

    def []=(key, value)
      Thread.main[@namespace] = value
    end

  end
end
