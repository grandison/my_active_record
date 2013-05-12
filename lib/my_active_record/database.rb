module MyActiveRecord
  class Database
    class << self
      def establish_connection(params)
        if params.delete(:adapter) == "csv"
          @adapter = MyActiveRecord::CsvAdapter.new(params)
        else
          raise "Unsupported adapter type"
        end
        load_database_schema
      end

      def table_to_model(table_name)
        @tables[table_name]
      end

      def load_database_schema
        @tables = {}
        MyActiveRecord::Base.descendants.each do |descendant|
          @tables[descendant.table_name] = descendant
          load_table_schema(descendant.table_name) if descendant.name
        end
      end

      def load_table_schema(table_name)
        table_to_model(table_name).fields = @adapter.load_table_schema(table_name)
      end

      def where(table_name, params)
        results = @adapter.where(table_name, params)
        model   = table_to_model(table_name)
        results.map do |result|
          model.load_data(result)
        end
      end

      def insert(table_name, model)
        model.id = model.class.last.id.to_i + 1
        @adapter.insert(table_name, model.to_row)
      end

      def update(table_name, model)
        @adapter.update(table_name, model.to_row)
      end

      def last(table_name)
        table_to_model(table_name).load_data(@adapter.last(table_name))
      end
    end
  end
end