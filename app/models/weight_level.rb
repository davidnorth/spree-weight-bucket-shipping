class WeightLevel < ActiveRecord::Base
  validates_presence_of :max, :cost
  validates_uniqueness_of :max
  
  
  def self.for_weight(weight)
    all(:order => "max").detect { |weight_level| weight < weight_level.max }
  end

end
