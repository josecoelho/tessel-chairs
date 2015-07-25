class ChairGroup < ActiveRecord::Base
  has_many :chairs

  def to_s
    name
  end
end

