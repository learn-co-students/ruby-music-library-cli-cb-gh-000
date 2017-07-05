module Concerns
  module Findable

    #Commented since the specs expects to be a flat module
    # module ClassMethods

      def find_by_name(name)
        self.all.find { |element| element.name == name }
      end

      def find_or_create_by_name(name)
        element = self.all.find { |element| element.name == name }
        if element.nil?
          element = self.new(name)
          element.save
        end
        element
      end

    # end

  end
end
