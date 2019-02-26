module Secured
    def authenticate_user!
        # Bearer xxxx
        token_regex = /Bearer (\w+)/
        # leer Header de auth, 
        headers = request.headers
        # verificar que sea valido, 
        if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
            token = headers['Authorization'].match(token_regex)[1]
            # debemos verificar que el token corresponda a un user
            if(Current.user = User.find_by_auth_token(token))
                return
            end
        end
        # verificar que token responda a un user
        render json: {error: 'Unauthorized'}, status: :unauthorized
    end
end