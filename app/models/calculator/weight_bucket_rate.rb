class Calculator::WeightBucketRate < Calculator
  def self.description
    I18n.t("weight_bucket_rate")
  end

  def self.register
    super
    ShippingMethod.register_calculator(self)
    ShippingRate.register_calculator(self)
  end

  def compute(line_items)
    return if line_items.empty?
    weight = Spree::WeightBucketShipping::Config[:unit_multiplier] * line_items.first.order.weight
    if weight_level = WeightLevel.for_weight(weight)
      weight_level.cost
    end
  end

  def available?(order)
    weight = Spree::WeightBucketShipping::Config[:unit_multiplier] * order.weight
    !! WeightLevel.for_weight(weight)
  end

end
