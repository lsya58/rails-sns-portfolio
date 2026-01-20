class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  validate :image_format
  
  private
  
  def image_format
    return unless image.attached?
    
    unless image.content_type.in?(%w[image/jpeg image/jpg image/png image/gif])
      errors.add(:image, 'must be a JPEG, JPG, PNG, or GIF')
    end
    
    if image.byte_size > 5.megabytes
      errors.add(:image, 'should be less than 5MB')
    end
  end
end