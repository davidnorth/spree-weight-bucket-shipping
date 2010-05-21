class WeightBucketShippingExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/weight_bucket_shipping"

  def activate
    [
      Calculator::WeightBucketRate,
    ].each(&:register)
    
    
    LineItem.class_eval do
      def weight
        quantity * variant.weight.to_f
      end
    end
    
    Order.class_eval do
      def weight
        line_items.map(&:weight).sum
      end
    end

  end

end
