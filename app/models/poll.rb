class Poll < ActiveRecord::Base
  attr_accessible :public_id, :pin, :title
  before_create :generate_pin
  before_create :generate_public_id

  has_many :comments

  def to_param
    "#{self.id}-#{self.public_id}"
  end


  def generate_pin
    digest_string = self.id.to_s << Time.now.to_i.to_s
    self.pin = Digest::MD5.hexdigest(digest_string)[0..3]
  end

  def generate_public_id
    self.public_id = SecureRandom.hex(10)[0..5]
  end
end
