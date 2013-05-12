module MyActiveRecord
  module Associations
    def has_one(*associations_list)
      associations_list.each do |association_name|
        define_method(association_name) do
          association_model = Database.table_to_model(association_name.to_s.pluralize)
          association_model.where(self.class.table_name.singularize + "_id" => self.id).first
        end
      end
    end
  end
end