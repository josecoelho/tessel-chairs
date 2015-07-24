class Chair < ActiveRecord::Base
  belongs_to :user
  delegate :name, to: :user, prefix: true, allow_nil: true

  belongs_to :chairs_manager
  delegate :name, to: :chairs_manager, prefix: true, allow_nil: true

  def booked?
    user != nil
  end

  def unbook!
    user = nil
    save

    self.update_tessel
  end

  def book_to current_user
    raise "This chair is already booked to #{self.user.name}" if self.user

    current_user.chair = self
    current_user.save

    self.update_tessel
  end

  def update_tessel
    ChairsManager.all.each do |manager|
      query = {}
      manager.chairs.each do |chair|
        query[chair.name] = chair.booked? ? 'booked' : 'vacant'
      end

      Thread.new {
        Rails.logger.info "GET #{manager.url} #{query}"
        HTTParty.get(manager.url, query: query)
      }
    end
  end
end
