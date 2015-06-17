class CreatePosts < ActiveRecord::Migration

  def change
    create_table :posts do |t|
      t.string :title
      t.text   :content
      t.string :author
      t.integer :author_id
      #t.references :author, index: true, class: 'User'
      t.timestamps null: false
    end
    add_foreign_key :posts, :author
  end

end
 