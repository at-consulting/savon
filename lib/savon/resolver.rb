class Savon
  class Resolver

    URL_PATTERN = /^http[s]?:/
    XML_PATTERN = /^</

    def initialize(http)
      @http = http
    end

    def resolve(location)
      case location
        when URL_PATTERN then load_from_remote(location)
        when XML_PATTERN then location
        else                  load_from_disc(location)
      end
    end

    private

    def load_from_remote(location)
      if @http
        @http.get(location)
      else
        raise Error, "HTTP adapter required to resolve #{location.inspect}"
      end
    end

    def load_from_disc(location)
      File.read(location)
    end

  end
end
