class Analytic < ActiveRecord::Base
  belongs_to :link
  has_many :unique_visitors
end
