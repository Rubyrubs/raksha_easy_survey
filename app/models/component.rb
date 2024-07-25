class Component < ApplicationRecord
  belongs_to :survey
    validates :position_x, :position_y, presence: true

end
