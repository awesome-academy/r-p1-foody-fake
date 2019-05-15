class ApplicationRecord < ActiveRecord::Base
  require "share_methods"
  self.abstract_class = true
end
