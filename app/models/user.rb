class User < ActiveRecord::Base
validates :username, :password, presence: true
validates :username, length: {minimum: 5, too_short: "Your username must be at least %{count} characters"}
validates :username, length: {maximum: 12, too_long: "Your username must not be more than %{count} characters"}
validates :password, length: {minimum: 8, too_short: "Your password must be at least %{count} characters"}
validates :password, length: {maximum: 20, too_long: "Your password must not be more thab %{count} characters"}
end