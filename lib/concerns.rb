module Concerns
  def self.included base
    base.include self::Creatable::InstanceMethods
    base.extend self::Creatable::ClassMethods
    base.extend self::Findable
  end
  module Findable
    def find_by_name name
      self.all.detect{|song| song.name == name }
    end

    def find_or_create_by_name name
      search_result = self.find_by_name name
      search_result ? search_result : self.create(name)
    end
  end
  module Creatable
    module ClassMethods
      def destroy_all
        self.all.clear
      end
      def create name
        obj = self.new name
        obj.save
        obj
      end
    end
    module InstanceMethods
      def save
        self.class.all << self
        self
      end
    end
  end
end
