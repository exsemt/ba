class Generic::Fact #< OpenStruct

  def self.create!(hash_attributes)
    new_group_id = GenericTable::FactValue.
      select('generic_table_fact_values.group').
      group('generic_table_fact_values.group').
      order('generic_table_fact_values.group').last.try(:group).to_i + 1

    GenericTable::FactValue.transaction do
      hash_attributes.each do |attr|
        GenericTable::FactValue.create!(
          :group => new_group_id,
          :dimension_value_id => attr[:fact_value] ? GenericTable::DimensionValue.find_by_value(attr[:header]).id : attr[:dimension_value_id].to_i,
          :value => attr[:fact_value] # attr.fact_value ? attr.fact_value : nil
        )
      end
    end

    true
  end

  ########################## Fact ###############################

  #attr_accessor :group
  #
  ##self.header.each do |header|
  ##  attr_accessor "#{header}"
  ##end
  #
  #def initialize(group, attributes)
  #  self.group = group
  #
  #  attributes.each do |attr|
  #    if attr.fact_value
  #      send("#{attr.header}=", attr.fact_value)
  #    else
  #      dimension = Generic::Dimension.new()
  #      dimension.id = attr.dimension_value_table_id
  #      send("#{attr.header}=", dimension)
  #    end
  #  end
  #end
  #
  #def get_header_attrs
  #  #self.instance_values['table'].keys # for OpenStruct
  #  self.instance_variable_names.map { |m|m.sub(/@/,'')}
  #end

end