module ForTehLulz
  class Montage
    attr_accessor :paths

    def initialize(*paths)
      @paths = paths
    end

    def go!
      result = Tempfile.new('montage')

      quoted_paths = paths.map do |path|
        %Q{'#{path}'}
      end

      quoted_result_path = %Q{'#{result.path}'}

      command = "montage %s -background '#000000' -geometry '+0+0' -tile 1 %s" % [quoted_paths.join(' '), quoted_result_path]
      system command

      result
    end

    def self.go!(*paths)
      new(*paths).go!
    end
  end
end
