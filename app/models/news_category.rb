class NewsCategory < ActiveRecord::Base
  attr_accessible :title

  def capitalized_title
    title.upcase
  end
end
