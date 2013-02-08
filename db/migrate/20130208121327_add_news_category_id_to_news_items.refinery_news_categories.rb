# This migration comes from refinery_news_categories (originally 2)
class AddNewsCategoryIdToNewsItems < ActiveRecord::Migration
  def change
    news_table = ::Refinery::News::Item.table_name
    add_column news_table, :news_category_id, :integer
    say "Adding news_category_id to news_items table"
    suppress_messages {add_index(news_table, :news_category_id)}
    say "and its index", true
  end
end
