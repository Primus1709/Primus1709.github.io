class Project < ApplicationRecord
  SLUG_FORMAT = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/
  URL_ATTRIBUTES = %i[repo_url live_url].freeze

  before_validation :fill_in_slug

  validates :title, presence: true, length: { maximum: 120 }
  validates :summary, presence: true, length: { maximum: 280 }
  validates :slug, presence: true, uniqueness: true,
                   format: { with: SLUG_FORMAT, message: "can only use lowercase letters, numbers and dashes" }
  validates :year, numericality: { only_integer: true, greater_than: 1990,
                                   less_than_or_equal_to: proc { Date.current.year + 1 } },
                   allow_nil: true
  validate :urls_use_http

  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(:position, year: :desc, created_at: :desc) }

  # "Java, Spring Boot, PostgreSQL" => ["Java", "Spring Boot", "PostgreSQL"]
  def tech_list
    tech_stack.to_s.split(",").map(&:strip).reject(&:blank?)
  end

  def case_study?
    [problem, approach, outcome].any?(&:present?)
  end

  # URLs use the slug (/projects/course-tracker) instead of the id (/projects/3).
  # slug_in_database keeps the URL stable while an edit form is being fixed.
  def to_param
    slug_in_database
  end

  private

  def fill_in_slug
    self.slug = (slug.presence || title).to_s.parameterize
  end

  def urls_use_http
    URL_ATTRIBUTES.each do |attribute|
      value = self[attribute]
      next if value.blank?

      uri = begin
        URI.parse(value)
      rescue URI::InvalidURIError
        nil
      end

      unless uri.is_a?(URI::HTTP) && uri.host.present?
        errors.add(attribute, "must be a full link starting with https://")
      end
    end
  end
end
