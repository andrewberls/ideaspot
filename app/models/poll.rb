class Poll < ActiveRecord::Base
  before_create :generate_pin
  attr_accessible :pin, :title

  def generate_pin
    digest_string = self.id.to_s << Time.now.to_i.to_s
    self.pin = Digest::MD5.hexdigest(digest_string)[0..3]
  end
end
