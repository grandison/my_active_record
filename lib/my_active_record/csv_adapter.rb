require 'csv'

module MyActiveRecord
  class CsvAdapter
    def initialize(params)
      @db_path = params[:db_path]
      raise "DB path is not set" unless @db_path
    end

    def load_table_schema(table_name)
      CSV.table(path_to_table(table_name)).headers
    end

    def table_schema(table_name)
      load_table_schema(table_name)
    end

    def where(table_name, params)
      results = []
      CSV.foreach(path_to_table(table_name), :headers => true) do |row|
        all_terms_succeded = params.all? do |key,value|
          row[table_schema(table_name).find_index(key.to_sym)].to_s == value.to_s
        end
        results << row if all_terms_succeded
      end
      results
    end

    protected

    def path_to_table(table_name)
      "#{@db_path}/#{table_name}.csv"
    end
  end
end