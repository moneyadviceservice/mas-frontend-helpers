require 'spec_helper'
require 'active_model'

module MAS
  module Frontend
    module Helpers
      module Validation
        describe OrderedErrors do

          let(:active_model_errors) do
            ActiveModel::Errors.new(double).tap do |errors|
              errors.add(:field_one, ->{ 'error one A' })
              errors.add(:field_one, ->{ 'error one B' })
              errors.add(:field_two, ->{ 'error two' })
              errors.add(:field_three, ->{ 'error three A' })
              errors.add(:field_three, ->{ 'error three B' })
              errors.add(:field_four, ->{ 'error four' })
            end
          end

          before do
            # we need to verify that full_message is used correctly, but don't want
            # the overhead of I18n, etc.
            allow(active_model_errors).to receive(:full_message) do |k, v|
              "#{k} has #{v}"
            end
          end

          it 'is enumerable' do
            expect(OrderedErrors.new(active_model_errors)).to be_an(Enumerable)
          end

          describe '#each' do
            # note: #each returns an enumerator if no block is given, so we validate
            #       it using #to_a, for readability's sake

            context 'when a field order is specified' do
              it 'yields each error, associated field, in the specified field order' do
                ordered_errors = OrderedErrors.new(active_model_errors, [:field_two, :field_four, :field_three, :field_one])

                expect(ordered_errors.each.to_a).to eq([
                  [:field_two, 'field_two has error two'],
                  [:field_four, 'field_four has error four'],
                  [:field_three, 'field_three has error three A'],
                  [:field_three, 'field_three has error three B'],
                  [:field_one, 'field_one has error one A'],
                  [:field_one, 'field_one has error one B'],
                ])
              end
            end

            context 'when no field order is specified' do
              it 'yields each error, associated field, in the message order of the wrapped ActiceModel::Errors instance' do
                ordered_errors = OrderedErrors.new(active_model_errors)

                expect(ordered_errors.each.to_a).to eq([
                  [:field_one, 'field_one has error one A'],
                  [:field_one, 'field_one has error one B'],
                  [:field_two, 'field_two has error two'],
                  [:field_three, 'field_three has error three A'],
                  [:field_three, 'field_three has error three B'],
                  [:field_four, 'field_four has error four'],
                ])
              end
            end

            context 'when a field order is partially specified' do
              it 'yields each error, associated field, in the specified field order, with unspecified fields yielded at the end of list' do
                ordered_errors = OrderedErrors.new(active_model_errors, [:field_two, :field_four])

                expect(ordered_errors.each.to_a).to eq([
                  [:field_two, 'field_two has error two'],
                  [:field_four, 'field_four has error four'],
                  [:field_one, 'field_one has error one A'],
                  [:field_one, 'field_one has error one B'],
                  [:field_three, 'field_three has error three A'],
                  [:field_three, 'field_three has error three B'],
                ])
              end
            end

            it 'yields results when a block is given' do
              yielded = false
              OrderedErrors.new(active_model_errors).each { yielded = true }

              Assert.fail("#each didn't yield anything") unless yielded
            end

          end

          describe '#each_for' do
            # note: #each_for returns an enumerator if no block is given, so we validate
            #       it using #to_a, for readability's sake

            it 'yields each error and its overall index, for the specified field, in order' do
              ordered_errors = OrderedErrors.new(active_model_errors, [:field_two, :field_four, :field_three, :field_one])

              expect(ordered_errors.each_for(:field_three).to_a).to eq([
                ['field_three has error three A', 2],
                ['field_three has error three B', 3],
              ])
            end

            it 'yields results when a block is given' do
              yielded = false
              OrderedErrors.new(active_model_errors).each_for(:field_one) { yielded = true }

              Assert.fail("#each didn't yield anything") unless yielded
            end
          end

        end
      end
    end
  end
end
