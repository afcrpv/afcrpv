Refinery::News::Item.class_eval do
  attr_accessible :news_category_id

  belongs_to :news_category, class_name: "Refinery::News::Category"
  delegate :title, to: :news_category, allow_nil: true, prefix: true
end
