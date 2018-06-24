module XssRspec
  module Checker
    module Visitor
      module PathManager
        class << self
          # path is actual url
          # path = /companies/god_company      => /companies/test_company
          # path = /companies/god_company/edit => /companies/test_company/edit
          def replace_path(path, method)
            route = route(path, method)
            ps = path.split('/')
            rs = route.split('/')
            return if ps.length != rs.length
            ps.zip(rs).map { |prs| # [["users", "users"], ["1000", ":id"]
              prs[0] == prs[1] ? prs[0] : convert(parse(prs[0], prs[1]))
            }.join("/")
          end

          # route 
          # route("/users/1000", "get") => "/users/:id"
          def route(path, method)
            return "/users/:id"
            #ActionController::Routing::Routes.recognize_path(path, {:method => method.to_sym})
          end

          private

          def parse(partition_path, partition_route)
            if partition_route.match(/.*id/) && partition_path.match(/[0-9]*/)
              return :integer
            end
            return :string
          end

          def convert(sym)
            if sym == :integer
              return 1
            else
              "asd"
            end
          end
        end
      end
    end
  end
end
