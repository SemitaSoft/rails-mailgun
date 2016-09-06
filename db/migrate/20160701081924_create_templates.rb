class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :content
      t.string :textcontent
      t.string :title
      t.string :from
      t.string :name
      t.timestamps null: false
    end
  end
end
