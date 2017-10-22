class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def [](id)
      find_by(id: id)
    end
  end
end
