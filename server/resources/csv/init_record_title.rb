require 'active_record'
require 'csv'


RECORD_TITLES_CSV = "./../resources/csv/record_title.csv"


ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./db/development.db"
)


class RecordTitle < ActiveRecord::Base
end


RecordTitle.delete_all


reader = CSV.open(RECORD_TITLES_CSV, 'r', :col_sep => "\t")
reader.each do |row|
  record_title = RecordTitle.new do |t|
    t.category = row[0]
    t.text = row[1]
  end
  record_title.save
end
