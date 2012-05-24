class Generic::Dimension < OpenStruct

  def self.get_attr_and_parents(kind, result = {})
    result.merge!("dimension_value_#{kind.id}" => {:aggregation => kind.aggregation.name, :dimension_value => kind.value})

    if kind.dimension_value
      get_attr_and_parents(kind.dimension_value, result)
    else
      result
    end
  end

  ########################### Create Dimension ############################
  # hash example:
  # hash = {"id"=>1, "day"=>20, "month"=>10, "year"=>2000, :dimension_name=>"date"}
  #
  # dimension = Generic::Dimension.new(hash)
  # dimension.create!
  # or
  # Generic::Dimension.new().create!(hash)
  def create!(hash = nil)
    Generic::Dimension.new(hash) if hash #todo

    aggregations = GenericTable::Aggregation.joins(:dimension).where('generic_table_dimensions.name = ?', self.dimension_name).order('parent_id ASC')

    dimension = {}
    dimension_value_parent_id = nil
    dimension_value = nil
    can_have_other_parent = true

    aggregations.each do |aggregation|
      attr = aggregation.name                                              # year   # month  # day    # year # month  # day    #
                                                                           #                          #                        #
      value = self.send(attr)                                              # 2000   # 4      # 20     # 2000 # 7      # 21     #
      if can_have_other_parent                                             #                          #                        #
        #dimension_value = find_by_aggregation_id_and_value_and_parent_id(aggregation.id, value, dimension_value_parent_id)
        dimension_value = GenericTable::DimensionValue.joins(:aggregation => :dimension).
          where('generic_table_dimensions.name = ?', self.dimension_name).
          find_by_aggregation_id_and_value_and_parent_id(aggregation.id, value, dimension_value_parent_id)
                                                                           # nil    # nil    # nil    #{id:5}# nil    # nil    #
        if dimension_value
          dimension.merge!("dimension_value_#{dimension_value.id}" =>
            {:aggregation => dimension_value.aggregation.name.to_s, :dimension_value => dimension_value.value.to_s})
        end
      end

      dimension_value_parent_id = if can_have_other_parent && dimension_value && dimension == self.class.get_attr_and_parents(dimension_value)
        dimension_value.id                                                 #                          # 5                      #
      else                                                                 #                          #                        #
        can_have_other_parent = false                                      #                          #                        #
        dimension = {}                                                     #                          #                        #
                                                                           #                          #                        #
        GenericTable::DimensionValue.create!(                              # create # create # create #      # create # create #
          :aggregation_id => aggregation.id,                               # 10     # 11     # 12     #      # 11     # 12     #
          :parent_id => dimension_value_parent_id,                         # nil    # 5      # 6      #      # 5      # 8      #
          :value => value                                                  # 2000   # 4      # 20     #      # 7      # 21     #
        ).id                                                               # 5      # 6      # 7      #      # 8      # 9      #
      end
    end
    { :last_id => dimension_value_parent_id }
  end


#private
#
#  def find_by_aggregation_id_and_value_and_parent_id(aggregation_id, value, parent_id)
#    GenericTable::DimensionValue.joins(:aggregation => :dimension).
#      where('generic_table_dimensions.name = ?', self.dimension_name).
#      where('generic_table_dimension_values.aggregation_id = ?', aggregation_id).
#      where("generic_table_dimension_values.parent_id #{parent_id ? ' = ' + parent_id.to_s : 'IS NULL'}").
#      where('generic_table_dimension_values.value = ?', value).first
#  end

end