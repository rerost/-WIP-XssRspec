class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  XssRspec.initialize
end