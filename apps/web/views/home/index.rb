module Web::Views::Home
  class Index
    include Web::View

    def files
      raw JSON.dump(Hash[File.read('mapping').split("\n").map { |line| line.split(':') }])
    end
  end
end
