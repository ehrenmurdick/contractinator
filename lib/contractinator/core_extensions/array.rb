module Contractinator
  module CoreExtensions
    module Array
      def contract_inspect
        if any?
          values = map(&:contract_inspect).uniq.join(', ')
          "[some #{values}]"
        else
          '[empty]'
        end
      end
    end
  end
end
