class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :record_title
  has_many :record_comments
end
