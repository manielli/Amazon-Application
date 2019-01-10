class NewsArticle < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    
    # validate :published_at_cannot_be_in_the_past
    validate :published_after_create

    after_save :titleized_title

    def publish
        # @published_at = Date.current
        update(published_at: Time.zone.now) # Brett's solution
    end

    def titleized_title
        self.title = self.title.downcase.titleize
    end

    scope :published, -> { where( 'published_at > created_at' ) }
    # Same as
    # def self.published
    #     where("published_at > created_at")
    # end

    
    private
    # def published_at_cannot_be_in_the_past
    #     if !(published_at.nil?) && (published_at < @created_at)
    #         self.errors.add(:published_at, "Can not be in the past")
    #     end
    # end
    # Brett's approach
    def published_after_create
        return unless published_at.present?
        errors.add(:base, "You cannot immediately publish this article") if published_at <= created_at
    end

end
