class Log
  include Mongoid::Document
  include Mongoid::Timestamps
  field :action, type: String
  field :user_id, type: Integer
  field :timestamp, type: Time
  has_many :users

  def log_action
    log_entry = { action: message, user_id: @current_user_id, timestamp: Time.now }
    MONGO_DB[:logs].insert_one(log_entry)
  end

end
