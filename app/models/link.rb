class Link < ActiveRecord::Base
  before_validation :url_check
  before_validation :generate_short_url
  # after_create :screenshot_scrape

  VALID_URL_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :long_url, presence: true, 
            format: { with: VALID_URL_REGEX }
  validates :short_url, uniqueness: true, 
            presence: true
  validates :clicks, presence: true
  belongs_to :user
  has_one :analytic

  default_scope{ order("created_at desc")}

  def display_short_url
    ENV['BASE_URL'] + self.short_url
  end

  def track_visits(request)
    analytic = Analytic.find_or_create_by(link_id: self.id)
    analytic.increment!(:visits, by = 1)
    if !analytic.unique_visitors.any? { |uv| uv.visitor_ip == request.ip }
      browser = Browser.new(ua: request.env["HTTP_USER_AGENT"])
      country = location_from_ip(request.ip)
      analytic.unique_visitors.create(visitor_ip: request.ip,
                                      browser: browser.name,
                                      browser_version: browser.version,
                                      platform: browser.platform.capitalize,
                                      country: country)
      analytic.increment!(:unique_visits, by = 1)
    end
  end

  def location_from_ip(ip)
    location = IpGeocoder.geocode(ip)
    location.country_code
  end

  # def visitor_is_unique
  #   # check if link has had any visitors
  # end

#   def screenshot_scrape
#     Screenshot.perform_async(self.id)
#     Scrape.perform_async(self.id)
#   end

#   class Screenshot
#   include Sidekiq::Worker

#   def perform(link_id)
#     link = Link.find(link_id)
#     file = Tempfile.new(["template_#{link.id.to_s}", '.jpg'], 'tmp', :encoding => 'ascii-8bit')
#     file.write(IMGKit.new(link.long_url, quality: 50, width: 600).to_jpg)
#     file.flush
#     link.snapshot = file
#     link.save
#     file.unlink
#   end

# end

# class Scrape
#   include Sidekiq::Worker

#   def perform(link_id)
#     link = Link.find(link_id)
#     agent = Mechanize.new
#     page = agent.get(link.long_url)
#     link.title = page.title
#     link.save
#   end

# end

# CarrierWave.configure do |config|
#   config.root = Rails.root.join('tmp')
#   config.cache_dir = 'carrierwave'

#   config.fog_credentials = {
#     :provider               => 'AWS',
#     :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
#     :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY']
#   }
#   config.fog_directory  = ENV['AWS_BUCKET']
# end

# class SnapshotUploader < CarrierWave::Uploader::Base
#   storage :file
#   storage :fog
#   def store_dir
#     "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#   end

#   def cache_dir
#     "#{Rails.root}/tmp/uploads"
#   end
# end

#  mount_uploader :snapshot, SnapshotUploader

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