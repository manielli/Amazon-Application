class User < ApplicationRecord

    def self.search search_term
        self.where("first_name ILIKE ?","#{search_term}") || self.where("last_name ILIKE ?","#{search_term}") || self.where("email ILIKE ?","#{search_term}")
    end
    
end
