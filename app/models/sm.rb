class Sm < ApplicationRecord
  def readble_victim
    to_obj = ActiveSupport::JSON.decode(to)
    "#{to_obj['who']}"
  end

  def readble_offender
    from_obj = ActiveSupport::JSON.decode(from)
    "#{from_obj['who']}"
  end
end
