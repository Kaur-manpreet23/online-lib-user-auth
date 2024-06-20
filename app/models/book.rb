class Book < ApplicationRecord
  has_one :manage_borrow, foreign_key: 'custom_manage_borrow_id'
end
