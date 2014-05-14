require 'action_view'

module MAS
  module Frontend
    module Helpers
      module Forms
        module Builders
          class Validation < ::ActionView::Helpers::FormBuilder
            include ActionView::Helpers::TagHelper
            include ActionView::Context

            # TODO partials
            # TODO i18n
            def validation_summary
              content_tag(:ol) do
                errors.map do |error|
                  field = (error[:field] == :base ? "" : "#{error[:field]} ".humanize)
                  content_tag(:li, "#{error[:number]}. #{field}#{error[:message]}")
                end.join.html_safe
              end
            end

            # TODO partials
            # TODO i18n
            def errors_for(object, field)
              content_tag(:ol) do
                errors.select{|hash| hash[:object] == object && hash[:field] == field}.map do |error|
                  field = (error[:field] == :base ? "" : "#{error[:field]} ".humanize)
                  content_tag(:li, "#{error[:number]}. #{field}#{error[:message]}")
                end.join.html_safe
              end
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

