module XssRspec
  module Checker
    module Logger
      class << self
        def log(path, alert_txt)
          alert = alert_txt.split('-')
          sprintf("%s-%s-%s", path, alert[0], alert[1])
        end

        private
        def sprintf(*args)
          Kernel.sprintf(args)
        end
      end
    end
  end
end
