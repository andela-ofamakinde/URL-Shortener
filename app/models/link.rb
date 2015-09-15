class Link < ActiveRecord::Base
  before_validation :url_check
  before_validation :generate_short_url

  VALID_URL_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :long_url, presence: true, 
            format: { with: VALID_URL_REGEX }
  validates :short_url, uniqueness: true, 
            presence: true
  validates :clicks, presence: true
  belongs_to :user

  default_scope{ order("created_at desc")}

  def display_short_url
    ENV['BASE_URL'] + self.short_url
  end

  private

  def url_check
    self.long_url = (self.long_url[0..2]=="www") ? "http://"+self.long_url : self.long_url
  end

  def generate_short_url
    begin
      self.short_url = SecureRandom.hex(2).to_s
    end while self.class.exists?(short_url: short_url)
  end

end