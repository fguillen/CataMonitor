Factory.define :user do |f|
  f.sequence(:name) { |n| "User Name #{n}" }
  f.sequence(:email) { |n| "useremail#{n}@mail.com" }
  f.password 'wadus'
  f.password_confirmation 'wadus'
end

Factory.define :query do |f|
  f.sequence(:query) { |n| "query_#{n}" }
  f.association :user
end