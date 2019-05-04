class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|

      t.string :title, null: false
      t.text :content, null: false
      # 外部参照カラムの設定
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
