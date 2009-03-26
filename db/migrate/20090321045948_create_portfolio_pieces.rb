class CreatePortfolioPieces < ActiveRecord::Migration
  def self.up
    create_table :portfolio_pieces do |t|
      t.string :title
      t.text :description
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
			t.integer :portfolio_id
      t.timestamps
    end
  end

  def self.down
    drop_table :portfolio_pieces
  end
end
