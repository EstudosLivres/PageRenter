require 'spec_helper'

describe Currency do
  context "Operator Format value" do
    # setup it vars to have the conversion tested, value: 1999 (nineteen ninety nine)
    pt_br = '1.999,00'
    en_us = '1,999.00'

    # it is the Rails conversion form the Form for Decimal input
    decimal_obj_pt_br = BigDecimal.new(pt_br.remove('.').remove(','))
    decimal_obj_en_us = BigDecimal.new(en_us.remove('.').remove(','))

    # Value like the card operator uses
    value_expected = '199900'

    # Convert PT_BR
    it 'PT_BR should be convertible' do
      pt_br_converted = Currency.to_operator_str decimal_obj_pt_br

      expect(pt_br_converted).to be_a String
      expect(pt_br_converted.index('.')).to be_nil
      expect(pt_br_converted.index(',')).to be_nil
      expect(pt_br_converted).to be_equals value_expected
    end

    # Convert EN_US
    it 'EN_US should be convertible' do
      en_us_converted = Currency.to_operator_str decimal_obj_en_us

      expect(en_us_converted).to be_a String
      expect(en_us_converted.index('.')).to be_nil
      expect(en_us_converted.index(',')).to be_nil
      expect(en_us_converted).to be_equals value_expected
    end
  end
end
