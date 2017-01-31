module Concerns
  module CommonFunctions
    module ClassMethods
      def destroy_all
        self.all.clear
      end

      def create(name)
        self.new(name).save
      end
    end

    module InstanceMethods
      def save
        self.class.all << self
        self
      end
    end
  end

  module HasManyCommon
    module InstanceMethods
      def add_song(song, attr)
        song.send("#{attr}=", self) if song.send("#{attr}") == nil
        self.songs << song unless self.songs.include?(song)
      end

      def has_many_though(attr)
        self.songs.collect do |song|
          song.send("#{attr}")
        end .uniq
      end
    end
  end
end
