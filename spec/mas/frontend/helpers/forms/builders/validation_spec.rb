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
              model.errors[:base] << "base error A"
              model.errors[:field_one] << "field_one error A"
              model.errors[:field_one] << "field_one error B"
              model.errors[:field_two] << "field_two error A"
              model
            end

            subject{ described_class.new(:model, model, nil, {}, {}) }

            describe :error_count do
              it 'returns number of errors' do
                expect(subject.error_count).to eql(4)
              end
            end

            describe :validation_summary do
              it 'lists all errors for the object' do
                expect(subject.validation_summary).to eql("<div class=\"validation-summary\"><ol class=\"validation-summary__list\"><li>1. base error A</li><li>2. <a href=\"#field_one-errors\">Field one field_one error A</a></li><li>3. <a href=\"#field_one-errors\">Field one field_one error B</a></li><li>4. <a href=\"#field_two-errors\">Field two field_two error A</a></li></ol></div>")
              end
            end

            describe :errors_for do
              it 'lists all errors for the field' do
                expect(subject.errors_for model, :field_one).to eql("<ol id=\"field_one-errors\"><li>2. Field one field_one error A</li><li>3. Field one field_one error B</li></ol>")

                expect(subject.errors_for model, :field_two).to eql("<ol id=\"field_two-errors\"><li>4. Field two field_two error A</li></ol>")
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
                  expect(subject.validation_summary).to eql("<div class=\"validation-summary\"><ol class=\"validation-summary__list\"><li>1. base error A</li><li>2. <a href=\"#field_one-errors\">Field one field_one error A</a></li><li>3. <a href=\"#field_one-errors\">Field one field_one error B</a></li><li>4. <a href=\"#field_two-errors\">Field two field_two error A</a></li><li>5. <a href=\"#field_a-errors\">Field a field_a error 1</a></li><li>6. <a href=\"#field_a-errors\">Field a field_a error 2</a></li><li>7. <a href=\"#field_b-errors\">Field b field_b error 1</a></li></ol></div>")
                end
              end
            end
          end
        end
      end
    end
  end
end
