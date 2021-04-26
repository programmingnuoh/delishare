class Deli < ApplicationRecord

  with_options presence:true do
      
  end

  belongs_to :user
  belongs_to :category
end
