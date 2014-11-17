class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    dimensions = Paperclip::Geometry.from_file(value.queued_for_write[:original].path)
    width = options[:width]
    height = options[:height]

    record.errors[attribute] << "#{I18n.t('file_errors.min_width')} #{width}px" if dimensions.width < width
    record.errors[attribute] << "#{I18n.t('file_errors.min_height')} #{height}px" if dimensions.height < height
  end
end