Factory.sequence :subdomain do |n|
  "test#{n}"
end

Factory.define :account do |a|
  a.subdomain { Factory.next(:subdomain) }
end