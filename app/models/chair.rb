class Chair < ActiveRecord::Base
  belongs_to :user
  delegate :name, to: :user, prefix: true, allow_nil: true

  belongs_to :chairs_manager
  delegate :name, to: :chairs_manager, prefix: true, allow_nil: true

  after_save :update_tessel

  def booked?
    user != nil
  end

  def unbook!
    user = nil
    save
  end

  def book_to current_user
    raise "This chair is already booked to #{self.user.name}" if self.user

    current_user.chair = self
    current_user.save
  end

  def update_tessel
    url = "http://10.1.0.46/"

    query = {}
    Chair.all.each do |chair|
      query[chair.name] = chair.booked? ? 'booked' : 'vacant'
    end

    Rails.logger.info "GET #{url} #{query}"
    HTTParty.get(url, query: query)
  end
end
