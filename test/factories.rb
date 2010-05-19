Factory.define :user do |f|
  f.sequence(:name) { |n| "User Name #{n}" }
  f.sequence(:email) { |n| "useremail#{n}@mail.com" }
  f.contract_plan 'basic'
  f.password 'wadus'
  f.password_confirmation 'wadus'
end

Factory.define :query do |f|
  f.sequence(:query) { |n| "query_#{n}" }
  f.association :user
end

Factory.define :mention do |f|
  f.sequence(:m_description) { |n| "Description #{n}" }
  f.sequence(:m_domain) { |n| "Domain #{n}" }
  f.sequence(:m_embed) { |n| "Embed #{n}" }
  f.sequence(:m_favicon) { |n| "Favicon #{n}" }
  f.sequence(:m_id) { |n| "Hash Id #{n}" }
  f.sequence(:m_image) { |n| "Image #{n}" }
  f.sequence(:m_language) { |n| "Language #{n}" }
  f.sequence(:m_link) { |n| "Link #{n}" }
  f.sequence(:m_source) { |n| "Source #{n}" }
  f.m_timestamp Time.now
  f.sequence(:m_title) { |n| "Title #{n}" }
  f.sequence(:m_type) { |n| "Type #{n}" }
  f.sequence(:m_user) { |n| "User #{n}" }
  f.sequence(:m_user_id) { |n| "User Id #{n}" }
  f.sequence(:m_user_image) { |n| "User Image #{n}" }
  f.sequence(:m_user_link) { |n| "User Link #{n}" }  
  f.register_at Time.now
  f.association :query
end