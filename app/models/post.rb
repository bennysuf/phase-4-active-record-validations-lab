class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: {in: ['Fiction', 'Non-Fiction']}
    validate :clickbait_check

    def num_check
        if title
            num = title.split.filter do |i| 
            i.to_i > 0
            end
            if num
              "Top #{num[0].to_i}"
            end
        end
    end

    def clickbait_check
        if title
         unless title.match?("Won't Believe") || title.match?("Secret") || title.match?("Guess") || title.match?(num_check)
            errors.add(:title, "not clickbait-y enough")
         end
        end
    end

end

# "Won't Believe"
# "Secret"
# "Top [number]"
# "Guess"