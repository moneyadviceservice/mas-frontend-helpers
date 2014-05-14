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
                expect(subject.validation_summary).to eql("<ol><li>1. Field one field_one error A</li><li>2. Field one field_one error B</li><li>3. Field two field_two error A</li></ol>")
              end
            end

            describe :errors_for do
              it 'lists all errors for the field' do
                expect(subject.errors_for model, :field_one).to eql("<ol><li>1. Field one field_one error A</li><li>2. Field one field_one error B</li></ol>")

                expect(subject.errors_for model, :field_two).to eql("<ol><li>3. Field two field_two error A</li></ol>")
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
                  expect(subject.validation_summary).to eql("<ol><li>1. Field one field_one error A</li><li>2. Field one field_one error B</li><li>3. Field two field_two error A</li><li>4. Field a field_a error 1</li><li>5. Field a field_a error 2</li><li>6. Field b field_b error 1</li></ol>")
                end
              end
            end
          end
        end
      end
    end
  end
end
