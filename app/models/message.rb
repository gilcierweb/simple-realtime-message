class Message < ApplicationRecord
  def self.count_message
    self.all.length.to_s
  end

end
