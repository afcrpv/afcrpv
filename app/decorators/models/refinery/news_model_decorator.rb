Refinery::News::Item.class_eval do
  attr_accessible :refinery_news_category_id
  belongs_to :category, foreign_key: :refinery_news_category_id, class_name: "::Refinery::NewsCategories::NewsCategory"
end
