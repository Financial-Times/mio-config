class Mio
  class Client
    class LoadOfBollocks < ArgumentError ; end
  end

  class Models
    class NoSuchField < ArgumentError ; end
    class MissingField < ArgumentError ; end
    class DataTypeError < ArgumentError ; end
    class DataValueError < ArgumentError ; end
  end
end
