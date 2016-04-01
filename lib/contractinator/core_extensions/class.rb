module Contractinator
  module CoreExtensions
    module Class
      def contract_inspect
        class_contract_inspect
      end

      def class_contract_inspect
        to_s
      end

      def instance_contract_inspect
        underscore(class_contract_inspect)
      end

      def underscore(string)
        string.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          downcase
      end
    end
  end
end
