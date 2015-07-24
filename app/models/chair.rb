class Chair < ActiveRecord::Base
  belongs_to :user

  def booked?
    user != nil
  end

  def book_to user
    raise "This chair is already booked to #{self.user.name}" if self.user

    booked_on = Chair.where(user: user)
    if booked_on
      booked_on.user = nil
      booked_on.save
    end

    self.user = user
    self.save
  end
end
