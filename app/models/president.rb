class President < User
  belongs_to :user
  has_many :events
end
