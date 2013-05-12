require 'rubygems'
require 'active_support/all'

module MyActiveRecord
  class Base
    extend ActiveSupport::DescendantsTracker

    class << self
      def table_name
        name.to_s.demodulize.underscore.pluralize
      end

      def fields=(fields_list)
        fields_list.each do |field_name|
          cattr_accessor field_name
        end
        @fields = fields_list
      end

      def fields
        @fields
      end
    end
  end
end