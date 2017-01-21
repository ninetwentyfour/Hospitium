module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.username
    end

    protected
      def find_verified_user
        # if verified_user = User.find_by(id: cookies.signed[:user_id])
        #   verified_user
        # else
        #   reject_unauthorized_connection
        # end
        verified_user = User.find_by(id: cookies.signed['user.id'])
        if verified_user && cookies.signed['user.expires_at'] > Time.now
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
# module ApplicationCable
#   class Connection < ActionCable::Connection::Base
#   end
# end
