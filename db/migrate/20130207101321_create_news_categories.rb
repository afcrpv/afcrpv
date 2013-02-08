class CreateNewsCategories < ActiveRecord::Migration
  def up
    create_table :news_categories do |t|
      t.string :title

      t.timestamps
    end

    names = %w(congres formation prix emploi)
    say_with_time "Creating #{names.to_sentence} categories" do
      names.each do |name|
        Refinery::News::Category.create!(title: name)
      end
    end
  end

  def down
    drop_table :news_categories
  end
end
