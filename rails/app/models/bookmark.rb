class Bookmark < ActiveRecord::Base

  validates :name, presence: true

  validates :url, presence: true, uri: { allowed_protocols: ['http', 'https'], disallowed_protocols: ['ftp', 'ssh'] }

  has_many :taggings, dependent: :destroy

  has_many :tags, through: :taggings

  # after_save :associate_tags

  def all_tags=(names)
    if names.present?
      self.tags = names.split(',').map do |name|
        Tag.where(name: name.strip).first_or_create! unless name.strip.blank?
      end
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

end