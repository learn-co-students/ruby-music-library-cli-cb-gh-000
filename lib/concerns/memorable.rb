
# Memorable module not in instructions but for less copy/paste (and since @@all does NOT work with inheritance).

module Concerns
  module Memorable

     module ClassMethods

      def destroy_all
        self.all.clear
      end

      def create(name)
        new_element = self.new(name)
        new_element.save
        new_element
      end

    end


    module InstanceMethods

      def initialize(name)
        @name = name
      end

      # Add to all only if not exists yet on it.
      def save
        all = self.class.all
        all << self if not all.include?(self)
      end

    end

  end
end
