class Helper

    def self.current_user(session_hash)
        @current_user ||= User.find_by(id: session_hash[:user_id])
    end

    def self.is_logged_in?(session_hash)
        if !!session_hash[:user_id]
            result = true
        else
            result = false
        end
        result
    end
end