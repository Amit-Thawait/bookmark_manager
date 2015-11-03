class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :name,       null: false
      t.string :url,        null: false
      t.string :description

      t.timestamps null: false
    end

    add_index(:bookmarks, :url)
  end
end
