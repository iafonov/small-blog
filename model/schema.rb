class Post < ActiveRecord::Base
  has_many :comments

  def formatted_body
    haml body
  end
end

class Comment  < ActiveRecord::Base
  belongs_to :post
end