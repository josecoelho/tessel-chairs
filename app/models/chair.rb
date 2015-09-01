class Chair < ActiveRecord::Base
  belongs_to :user
  delegate :name, to: :user, prefix: true, allow_nil: true

  belongs_to :chairs_manager
  delegate :name, to: :chairs_manager, prefix: true, allow_nil: true

  belongs_to :chair_group
  delegate :name, to: :chair_group, prefix: true, allow_nil: true

  scope :available, ->(){ where(user_id: nil) }

  after_save :update_tessel

  def booked?
    user != nil
  end

  def unbook!
    self.user_id = nil
    save
  end

  def book_to current_user
    raise "This chair is already booked to #{self.user.name}" if self.user

    current_user.chair = self
    current_user.save
  end

  def update_tessel
    ChairsManager.all.each do |manager|
      query = {}
      manager.chairs.each do |chair|
        unless chair.name_in_manager.nil?
          query[chair.name_in_manager] = chair.booked? ? 'booked' : 'vacant'
        end
      end

      Thread.new {
        Rails.logger.info "GET #{manager.url} #{query}"
        HTTParty.get(manager.url, query: query)
      }
    end
  end

  def to_s
   "#{chair_group_name}#{name}"
  end
end
