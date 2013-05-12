require 'rubygems'
require 'active_support/all'
require 'my_active_record/associations'

module MyActiveRecord
  class Base
    extend ActiveSupport::DescendantsTracker
    extend Associations


    class << self
      def initialize(params = {})
        model = super
        params.each do |key, value|
          send("#{key}=", value)
        end
        model
      end

      def table_name
        name.to_s.demodulize.underscore.pluralize
      end

      def fields=(fields_list)
        fields_list.each do |field_name|
          attr_accessor field_name
        end
        @fields = fields_list
      end

      def fields
        @fields
      end

      def find(model_id)
        where(:id => model_id).first
      end

      def where(params)
        Database.where(table_name, params)
      end

      def load_data(data)
        model = new
        fields.each_with_index do |field_name,index|
          model.send("#{field_name}=", data[index])
        end
        model
      end
    end
  end
end