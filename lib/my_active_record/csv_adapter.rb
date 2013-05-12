require 'csv'

module MyActiveRecord
  class CsvAdapter
    def initialize(params)
      @db_path = params[:db_path]
      raise "DB path is not set" unless @db_path
    end

    def load_table_schema(table_name)
      CSV.table("#{@db_path}/#{table_name}.csv").headers
    end
  end
end