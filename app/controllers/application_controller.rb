class ApplicationController < ActionController::API

    def jwt_secret
      ENV["JWT_SECRET"]
    end
  
    private
    def token(user)
      exp = Time.now.to_i + (60*60*24*30)
      payload = { 
        sub: user.id,
        exp: exp
      }
      token = JWT.encode(payload, jwt_secret, 'HS256')
      return token
    end
  
    def decode_jwt
      begin
        token = request.headers["Authorization"].split(' ')[1]
        decoded_array = JWT.decode( token, jwt_secret, true, { algorithm: 'HS256' } )
        payload = decoded_array.first
        return payload
      rescue #JWT::VerificationError
        return nil
      end
    end
  
    def current_user_id
      decoded = decode_jwt
      return decoded['sub']
    end
  
    def client_has_valid_token?
      begin
        user = User.find(current_user_id)
        return !!user
      rescue
        return false
      end
    end

    def require_auth
      render json: {error: 'Unauthorized'}, status: :unauthorized unless client_has_valid_token?
    end
  
  end
  