class Tool < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :user_id, message: "Tool needs to be unique to the user."}
  belongs_to :user
end
