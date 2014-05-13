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
                    {number: 1, object: model, field: :field_one, message: "field_one error A"},
                    {number: 2, object: model, field: :field_one, message: "field_one error B"},
                    {number: 3, object: model, field: :field_two, message: "field_two error A"}
                  ]
                )
              end
            end

            describe :errors_for do
              it 'lists all errors for the field' do
                expect(subject.errors_for model, :field_one).to eql(
                  [
                    {number: 1, object: model, field: :field_one, message: "field_one error A"},
                    {number: 2, object: model, field: :field_one, message: "field_one error B"}
                  ]
                )

                expect(subject.errors_for model, :field_two).to eql(
                  [
                    {number: 3, object: model, field: :field_two, message: "field_two error A"},
                  ]
                )
              end
            end

            context "when there are multiple objects" do
              let(:another_model) do
                model = ValidationBuilderModel.new
                model.errors[:field_a] << "field_a error 1"
                model.errors[:field_a] << "field_a error 2"
                model.errors[:field_b] << "field_b error 1"
                model
              end

              describe :validation_summary do
                before :each do
                  subject.validates model, another_model
                end

                it 'lists all errors for the objects' do
                  expect(subject.validation_summary).to eql(
                    [
                      {number: 1, object: model, field: :field_one, message: "field_one error A"},
                      {number: 2, object: model, field: :field_one, message: "field_one error B"},
                      {number: 3, object: model, field: :field_two, message: "field_two error A"},

                      {number: 4, object: another_model, field: :field_a, message: "field_a error 1"},
                      {number: 5, object: another_model, field: :field_a, message: "field_a error 2"},
                      {number: 6, object: another_model, field: :field_b, message: "field_b error 1"}
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
end
