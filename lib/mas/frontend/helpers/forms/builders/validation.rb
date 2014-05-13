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

            def errors_for(object, field)
              errors.select{|s_object, s_field, _| s_object == object && s_field == field}
            end

            private

            def errors
              @errors ||= object.errors.map do |field,message|
                [object, field, message]
              end
            end
          end
        end
      end
    end
  end
end

