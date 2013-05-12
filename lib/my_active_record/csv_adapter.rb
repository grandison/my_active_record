require 'csv'

module MyActiveRecord
  class CsvAdapter
    def initialize(params)
      @db_path = params[:db_path]
      raise "DB path is not set" unless @db_path
    end

    def load_table_schema(table_name)
      raise("Csv file #{table_name}.csv should be created") unless File.exists?(path_to_table(table_name))
      schema = CSV.table(path_to_table(table_name)).headers
      raise("ID column should exist") unless schema.include?(:id)
      schema
    end

    def where(table_name, params)
      results = []
      read_table(table_name).each do |row|
        all_terms_succeded = params.all? do |key,value|
          row[table_schema(table_name).find_index(key.to_sym)].to_s == value.to_s
        end
        results << row if all_terms_succeded
      end
      results
    end

    def insert(table_name, row)
      CSV.open(path_to_table(table_name), "ab") do |csv|
        csv << row
      end
    end

    def update(table_name, row)
      old_csv = read_table(table_name)
      CSV.open(path_to_table(table_name), "wb") do |csv|
        old_csv.each do |old_row|
          if row[0] == old_row[0]
            csv << row
          else
            csv << old_row
          end
        end
      end
    end

    def last(table_name)
      read_table(table_name).last
    end

    protected

    def read_table(table_name)
      CSV.read(path_to_table(table_name), :headers => true).to_a
    end

    def table_schema(table_name)
      load_table_schema(table_name)
    end

    def path_to_table(table_name)
      "#{@db_path}/#{table_name}.csv"
    end
  end
end