# == Schema Information
#
# Table name: slices
#
#  id         :integer          not null, primary key
#  pizza_id   :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Slice < ActiveRecord::Base
  belongs_to :pizza
  belongs_to :order

  validates :pizza_id, presence: true

  #### ANALYTICS ####

  def self.total_slices_by_type
    Pizza.pizzas_by_popularity.pluck("pizzas.topping, COUNT(slices.id)")
  end

end
