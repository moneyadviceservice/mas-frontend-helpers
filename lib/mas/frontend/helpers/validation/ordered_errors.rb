module MAS
  module Frontend
    module Helpers
      module Validation
        class OrderedErrors
          include Enumerable

          attr_reader :active_model_errors, :field_order
          private :active_model_errors

          def initialize(active_model_errors, field_order = [])
            @active_model_errors = active_model_errors
            @field_order = Array(field_order)
          end

          def each(&block)
            all_errors.each(&block)
          end

          def each_for(field, &block)
            each_with_index
              .select { |field_and_message, index| field_and_message[0] == field }
              .map { |field_and_message, index| [field_and_message[1], index] }
              .each(&block)
          end

        private

          def all_errors
            @all_errors ||= (field_order + active_model_errors.messages.keys).uniq.flat_map do |field|
              active_model_errors[field].map do |message|
                [field, active_model_errors.full_message(field, message)]
              end
            end
          end

        end
      end
    end
  end
end
