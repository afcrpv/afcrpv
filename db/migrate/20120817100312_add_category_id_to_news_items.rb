class AddCategoryIdToNewsItems < ActiveRecord::Migration
  def up
    unless ::Refinery::News::Item.column_names.map(&:to_sym).include?(:refinery_news_category_id)
      add_column ::Refinery::News::Item.table_name, :refinery_news_category_id, :integer
    end
  end
  def down
    if ::Refinery::News::Item.column_names.map(&:to_sym).include?(:refinery_news_category_id)
      remove_column ::Refinery::News::Item.table_name, :refinery_news_category_id
    end
  end
end
