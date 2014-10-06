class CreateRecordTitles < ActiveRecord::Migration
  def change
    create_table :record_titles do |t|
      t.string :category
      t.string :text
      t.timestamps
    end
  end
end
