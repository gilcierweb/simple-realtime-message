class Message < ActiveRecord::Base
  def self.count_message
    self.all.length.to_s
  end

end
