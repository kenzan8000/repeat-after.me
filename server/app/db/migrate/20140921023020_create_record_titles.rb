class CreateRecordTitles < ActiveRecord::Migration
  def change
    create_table :record_titles do |t|
      t.string :category_en
      t.string :category_jp
      t.string :text_en
      t.string :text_jp
      t.timestamps
    end
  end
end
