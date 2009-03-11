class AddPublishDateToBlogPost < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :publish_date, :datetime
  end

  def self.down
    remove_column :blog_posts, :publish_date
  end
end
