class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~   /^[\w\-\.]+@[\w\-]+((\.[\w\-]{2,4})+)$/
      record.errors[attribute] << (options[:message] || "is not a valid email")
    end
  end
end