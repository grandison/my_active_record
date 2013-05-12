require 'csv'

module MyActiveRecord
  class CsvAdapter
    def initialize(params)
      @db_path = params[:db_path]
      raise "DB path is not set" unless @db_path
    end

    def load_table_schema(table_name)
      @table_schema ||= CSV.table(path_to_table(table_name)).headers
    end

    def table_schema(table_name)
      load_table_schema(table_name)
    end

    def where(table_name, params)
      results = []
      CSV.foreach(path_to_table(table_name)) do |row|
        params.each do |key,value|
          next unless row[table_schema(table_name).find_index(key)].to_s == value.to_s
        end
        results << row
      end
      results
    end

    protected

    def path_to_table(table_name)
      "#{@db_path}/#{table_name}.csv"
    end
  end
end