module Utility
  class JsonWebToken
    # TODO: move to secret and generate unique AUD
    ISS = 'e-manifest.com'.freeze
    AUD = '238d4793-70de-4183-9707-48ed8ecd19d9'.freeze

    class << self
      def encode(payload, exp = 48.hours.from_now)
        # set token expiration time
        payload[:exp] = exp.to_i
        payload[:aud] = AUD
        payload[:iss] = ISS
        # this encodes the user data(payload) with our secret key
        JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
      end

      def decode(token)
        # decodes the token to get user data (payload)
        body = JWT.decode(
          token,
          Rails.application.secrets.secret_key_base,
          true,
          { verify_iss: true, iss: ISS, verify_aud: true, aud: AUD, algorithm: 'HS256' }
        )[0]
        HashWithIndifferentAccess.new body

      # raise custom error to be handled by custom handler
      rescue JWT::ExpiredSignature, JWT::VerificationError => e
        raise ExceptionHandler::ExpiredSignature, e.message
      rescue JWT::DecodeError, JWT::VerificationError => e
        raise ExceptionHandler::DecodeError, e.message
      end
    end
  end
end
