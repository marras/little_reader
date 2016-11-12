module Web::Views::Home
  class Index
    include Web::View
    
    def files
      Dir.glob('apps/web/assets/images/*')
    end
  end
end
