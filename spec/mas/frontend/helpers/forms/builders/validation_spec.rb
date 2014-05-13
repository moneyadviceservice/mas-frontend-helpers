require 'spec_helper'
require 'active_model'

module MAS
  module Frontend
    module Helpers
      module Forms
        module Builders
          describe Validation do
            class ValidationBuilderModel
              include ActiveModel::Validations
            end

            let(:model) do
              model = ValidationBuilderModel.new
              model.errors[:field_one] << "field_one error A"
              model.errors[:field_one] << "field_one error B"
              model.errors[:field_two] << "field_two error A"
              model
            end

            subject{ described_class.new :model, model, nil, {} }

            describe :validation_summary do
              it 'lists all errors for the object' do
                expect(subject.validation_summary).to eql(
                  [
                    [model, :field_one, "field_one error A"],
                    [model, :field_one, "field_one error B"],
                    [model, :field_two, "field_two error A"]
                  ]
                )
              end
            end

            describe :errors_for do
              it 'lists all errors for the field' do
                expect(subject.errors_for model, :field_one).to eql(
                  [
                    [model, :field_one, "field_one error A"],
                    [model, :field_one, "field_one error B"]
                  ]
                )

                expect(subject.errors_for model, :field_two).to eql(
                  [
                    [model, :field_two, "field_two error A"]
                  ]
                )
              end
            end
          end
        end
      end
    end
  end
end
