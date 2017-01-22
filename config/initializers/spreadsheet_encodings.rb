module Spreadsheet
  module Encodings
    def client(string, internal = 'UTF-16LE')
      string = string.dup
      string.force_encoding internal
      string.encode Spreadsheet.client_encoding
    end

    def internal(string, client = Spreadsheet.client_encoding)
      string = string.dup
      string.force_encoding client
      string.encode('UTF-16LE').force_encoding('ASCII-8BIT')
    end

    def utf8(string, client = Spreadsheet.client_encoding)
      string = string.dup
      string.force_encoding client
      string.encode('UTF-8')
    end
  end
end
