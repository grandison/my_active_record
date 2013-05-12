module MyActiveRecord
  class Database
    class << self
      def establish_connection(params)
        if params.delete(:adapter) == "csv"
          @adapter = MyActiveRecord::CsvAdapter.new(params)
        else
          raise "Unsupported apapter type"
        end
        load_database_schema
      end

      def load_database_schema
        MyActiveRecord::Base.descendants.each do |descendant|
          descendant.fields = load_table_schema(descendant.table_name)
        end
      end

      def load_table_schema(table_name)
        @adapter.load_table_schema(table_name)
      end
    end
  end
end