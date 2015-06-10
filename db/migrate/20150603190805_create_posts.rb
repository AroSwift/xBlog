class CreatePosts < ActiveRecord::Migration

  def change
    create_table :posts do |t|
      t.string :title
      t.string :author #Add connection to table users
      t.text   :content

      t.timestamps null: false
    end

  end
end
