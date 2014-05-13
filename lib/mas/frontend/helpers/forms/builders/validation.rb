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

            def validates(*models)
              @error_models = models
            end

            private

            def error_models
              @error_models ||= [object]
            end

            def errors
              return @errors if @errors

              @errors = []

              error_models.each do |model|
                model.errors.each do |field,message|
                  @errors << [model, field, message]
                end
              end

              @errors
            end
          end
        end
      end
    end
  end
end

