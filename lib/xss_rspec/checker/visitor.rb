require_relative "visitor/path_manager"

module XssRspec
  module Checker
    module Visitor
      Request = Struct.new(:url, :method) 
      class << self
        def visit_all
          requests = [Request.new("/users/100", "GET")]
          requests.map { |r|
            PathManager.replace_path(r.url, r.method)
          }
        end
      end
    end
  end
end
