class Poll < ActiveRecord::Base
  attr_accessible :pin, :title
  before_create :generate_pin

  has_many :comments
  has_many :ideas

  def generate_pin
    digest_string = self.id.to_s << Time.now.to_i.to_s
    self.pin = Digest::MD5.hexdigest(digest_string)[0..3]
  end
end
