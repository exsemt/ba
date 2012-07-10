class Generic::Fact
  def self.save!(hash_attributes)
    new_group_id = GenericTable::FactValue.
      select('generic_table_fact_values.group').
      group('generic_table_fact_values.group').
      order('generic_table_fact_values.group').last.try(:group).to_i + 1

    GenericTable::FactValue.transaction do
      hash_attributes.each do |attr|
        GenericTable::FactValue.create!(
          :group => new_group_id,
          :dimension_value_id =>
            attr[:fact_value] ? GenericTable::DimensionValue.find_by_value(attr[:header]).id : attr[:dimension_value_id].to_i,
          :value => attr[:fact_value]
        )
      end
    end

    true
  end
end