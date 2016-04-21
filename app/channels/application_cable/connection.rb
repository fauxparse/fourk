# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
      logger.add_tags("ActionCable", current_user.name)
    end

    private

    def find_user
      User.find_by(id: cookies.signed[:user_id]) ||
        reject_unauthorized_connection
    end
  end
end
