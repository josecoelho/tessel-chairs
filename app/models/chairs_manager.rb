class ChairsManager < ActiveRecord::Base
  has_many :chairs

  def self.register name, url, chairs
    manager = find_by(name: name);
    manager = ChairsManager.new unless manager

    manager.name = name
    manager.url = url

    chairs.each do |chair_name|
      Rails.logger.info "Registering chair #{chair_name} to #{name}"
      chair = nil
      chair = Chair.find_by(name: chair_name, chairs_manager: manager) unless manager.new_record?
      chair = Chair.new unless chair

      chair.name = chair_name
      manager.chairs << chair
    end

    manager.save
  end
end
