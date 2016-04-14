class Mio
  class Client
    class LoadOfBollocks < ArgumentError ; end
  end

  class Model
    class NoSuchField < ArgumentError ; end
    class MissingField < ArgumentError ; end
    class DataTypeError < ArgumentError ; end
    class DataValueError < ArgumentError ; end
    class NoSuchResource < ArgumentError ; end
    class EmptyField < ArgumentError ; end
  end

  class Config
    class FileMissing < IOError ; end
  end
end
