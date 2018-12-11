class Product < ApplicationRecord

    validates(
        :title,
        presence: true,
        uniqueness: true
    )

    validates(
        :price,
        numericality: {
            greater_than_or_equal_to: 0
        }
    )

    # validates(
    #     :sale_price,
    #     numericality: {
    #         lesser_than: self.price
    #     }
    # )

    validates(
        :description,
        presence: true,
        length: { minimum: 10 }
    )

    validate(:no_reserved_name)
    validate(:sets_sale_price)
    validate(:sale_price_less_than_price)
    before_validation(:set_default_hit_count)
    before_validation(:set_default_price)
    after_validation(:sets_sale_price)
    before_save(:capitalize)
    


    def self.search str
         
        if self.where("title ILIKE ?","#{str}")
            self.where("title ILIKE ?","#{str}").each { |product| new_hit_count = product.hit_count + 1; product.update(hit_count: new_hit_count) }
        end
        self.where("title || description ILIKE ?","%#{str}%") || self.where("description ILIKE ?", "%#{str}%")
    end
    
    private
    def no_reserved_name
        if title&.downcase&.include?("apple") || title&.downcase&.include?("microsoft") || title&.downcase&.include?("sony")
            self.errors.add(:title,"must not be one of these reserved names: Apple, Microsoft & Sony")
        end
    end

    def sale_price_less_than_price
        if sale_price && sale_price > price
            self.errors.add(:sale_price, "can not be higher than price, you are being ripped off!!!!")
        end
    end

    def sets_sale_price
        self.sale_price ||=  self.price
    end

    def set_default_price
        self.price ||= 1
    end

    def set_default_hit_count
        self.hit_count ||= 0
    end

    def capitalize
        self.title.capitalize
    end
end
