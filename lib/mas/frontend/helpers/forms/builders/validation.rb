require 'action_view'

module MAS
  module Frontend
    module Helpers
      module Forms
        module Builders
          class Validation < ::ActionView::Helpers::FormBuilder
            def validation_summary
              errors
            end

            private

            def errors
              object.errors.map do |field,message|
                [object, field, message]
              end
            end
          end
        end
      end
    end
  end
end

