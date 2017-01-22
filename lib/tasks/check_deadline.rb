require "#{Rails.root}/app/models/book.rb"
require "#{Rails.root}/app/models/deadline.rb"

class Tasks::CheckDeadline
  def self.execute
    Book.where(status: 1).each do |book|
      next unless book.deadline.deadline < Time.now
      book.update(status: 0)
      book.cancel_negotiate
      book.destroy_all_negotiate
      book.deadline.destroy
    end
  end
end
