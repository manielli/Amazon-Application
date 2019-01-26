class Tag < ApplicationRecord

    has_many :taggings, dependent: :destroy
    has_many :products, through: :taggings

    before_validation :downcase_name

    validates(
        :name, 
        presence: true, 
        uniqueness: { 
            case_insensitive: false 
        }
    )

    private
    def downcase_name
        self.name = self.name.downcase

        self.name&.downcase!
    end
end
