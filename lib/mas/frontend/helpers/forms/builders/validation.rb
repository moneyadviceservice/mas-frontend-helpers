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
              errors.select{|hash| hash[:object] == object && hash[:field] == field}
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
              counter = 1

              # TODO each with index

              error_models.each do |model|
                model.errors.each do |field,message|
                  @errors << {number: counter, object: model, field: field, message: message}
                  counter += 1
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

