class Mio
  class Client
    class LoadOfBollocks < ArgumentError ; end
  end

  class Model
    class DataTypeError < ArgumentError ; end
    class DataValueError < ArgumentError ; end
    class EmptyField < ArgumentError ; end
    class MissingField < ArgumentError ; end
    class NoSuchField < ArgumentError ; end
    class NoSuchResource < ArgumentError ; end
    class NoSuchVisibility < ArgumentError ; end
  end

  class Config
    class FileMissing < IOError ; end
  end
end
