Factory.define(:user) do |u|
  u.sequence(:email) { |n| "example#{n}@example.com" }
  u.password "test"
  u.password_confirmation "test"
  u.active true
end

Factory.define(:inactive_user, :class => User) do |u|
  u.sequence(:email) { |n| "inactive#{n}@example.com" }
end

Factory.define(:user_activating, :class => User) do |u|
  u.password "test"
  u.password_confirmation "test"
  u.openid_identifier "http://google.com/"
end