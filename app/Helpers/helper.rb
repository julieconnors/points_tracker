class Helper

    def self.current_user(session_hash)
        user = User.all.find(session_hash[:user_id])
        user
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