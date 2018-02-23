class Sm < ApplicationRecord
  def readble_victim
    to_obj = ActiveSupport::JSON.decode(to)
    puts to_obj
    string = "#{to_obj['who']} #{to_obj['number']}"
    puts string
    string
  end

  def readble_offender
    from_obj = ActiveSupport::JSON.decode(from)
    puts from_obj
    string = "#{from_obj['who']} #{from_obj['number']}"
    puts string
    string
  end
end
