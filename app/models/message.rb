class Message < ApplicationRecord
  normalizes :name, with: ->(name) { name.strip }
  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 254 },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "doesn't look like an email address" }
  validates :body, presence: true, length: { in: 10..5000 }

  scope :unread, -> { where(read_at: nil) }
  scope :newest_first, -> { order(created_at: :desc) }

  def read?
    read_at.present?
  end

  def mark_read!
    update!(read_at: Time.current) unless read?
  end
end
