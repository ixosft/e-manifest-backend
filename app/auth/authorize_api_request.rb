class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(jwt)
    @jwt = jwt
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.active.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= Utility::JsonWebToken.decode(token)
  end

  def token
    if @jwt.present?
      return @jwt
    else errors.add(:token, 'Missing token')
    end

    nil
  end
end
