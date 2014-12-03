require 'spec_helper'

describe Currency do
  context "Operator Format value" do
    # setup it vars to have the conversion tested, value: 1999 (nineteen ninety nine)
    pt_br = '1.999,00'
    en_us = '1,999.00'

    # Value like the card operator uses
    operator_expected_value = '199900'
    decimal_expected_value = BigDecimal.new '1999.00'

    # it is the Rails conversion form the Form for Decimal input
    decimal_obj_pt_br = BigDecimal.new(pt_br.remove('.').remove(','))
    decimal_obj_en_us = BigDecimal.new(en_us.remove('.').remove(','))

    # Conversions
    pt_br_converted = Currency.to_operator_str decimal_obj_pt_br
    en_us_converted = Currency.to_operator_str decimal_obj_en_us
    decimal_converted = Currency.decimal_from_operator_str operator_expected_value

    context 'Decimal to Operator' do
      # Convert PT_BR
      it 'PT_BR should be convertible' do
        expect(pt_br_converted).to be_a String
        expect(pt_br_converted.index('.')).to be_nil
        expect(pt_br_converted.index(',')).to be_nil
        expect(pt_br_converted).to be_equals operator_expected_value
      end

      # Convert EN_US
      it 'EN_US should be convertible' do
        expect(en_us_converted).to be_a String
        expect(en_us_converted.index('.')).to be_nil
        expect(en_us_converted.index(',')).to be_nil
        expect(en_us_converted).to be_equals operator_expected_value
      end
    end

    context 'Operator to Decimal' do
      it 'must be simple decimal, not formatted' do
        expect(decimal_converted).to be_a BigDecimal
        expect(decimal_converted).to be == decimal_expected_value
      end
    end
  end
end
