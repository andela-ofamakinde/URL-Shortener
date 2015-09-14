class Link < ActiveRecord::Base
  before_validation :generate_short_url, :on => :create 
  validates :short_url, uniqueness: true
  validates :long_url, presence: true
  validates :clicks, presence: true

  def generate_short_url
    begin
      self.short_url = SecureRandom.hex(2).to_s
    end while self.class.exists?(short_url: short_url)
  end

  def display_short_url
    ENV['BASE_URL'] + self.short_url
  end


end