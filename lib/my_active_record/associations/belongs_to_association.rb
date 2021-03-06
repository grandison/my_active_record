module MyActiveRecord
  module Associations
    def belongs_to(*associations_list)
      associations_list.each do |association_name|
        define_method(association_name) do
          association_model = Database.table_to_model(association_name.to_s.pluralize)
          association_model.where(:id => self["#{association_name.to_s.singularize}_id"]).first
        end
      end
    end
  end
end