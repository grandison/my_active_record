require 'rubygems'
require 'active_support/all'
require 'my_active_record/associations'

module MyActiveRecord
  class Base
    extend ActiveSupport::DescendantsTracker
    extend Associations

    def initialize(params = {})
      params.each do |key, value|
        self[key] = value
      end
      self
    end

    class << self
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
          model[field_name] = data[index]
        end
        model
      end

      def create(params)
        new(params).save
      end

      def last
        Database.last(table_name)
      end
    end

    def save
      if self.id
        Database.update(self.class.table_name, self)
      else
        Database.insert(self.class.table_name, self)
      end
    end

    def [](key)
      send(key)
    end

    def []=(key, value)
      send("#{key}=", value)
    end

    def to_row 
      self.class.fields.map do |field|
        self[field]
      end
    end
  end
end