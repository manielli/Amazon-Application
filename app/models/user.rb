class User < ApplicationRecord
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    
    has_secure_password

    validates(
        :first_name,
        presence: true
    )

    validates(
        :last_name,
        presence: true
    )

    validates(
        :email,
        presence: true,
        uniqueness: true,
        format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i 
    )

    def self.search search_term
        self.where("first_name ILIKE ?","#{search_term}") || self.where("last_name ILIKE ?","#{search_term}") || self.where("email ILIKE ?","#{search_term}")
    end
    
    def full_name
        "#{first_name} #{last_name}".strip
    end
end
