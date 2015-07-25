class ChairsManager < ActiveRecord::Base
  has_many :chairs

  def self.register name, url, available_chairs
    manager = find_by(name: name)
    manager = ChairsManager.new unless manager

    manager.name = name
    manager.available_chairs = available_chairs
    manager.url = url

    manager.save
  end

  def available_chairs_arr
    available_chairs.split(",")
  end

  def to_s
    name
  end
end