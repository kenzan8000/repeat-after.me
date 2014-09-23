class CreateRecordTitles < ActiveRecord::Migration
  def change
    create_table :record_titles do |t|
      t.string :text
      t.timestamps
    end
  end
end
