require 'hashie'
class Person < Hashie::Dash
  property :name
  property :email
  property :occupation, :default => 'Rubyist'
end

p = Person.new
puts p.name # => nil
puts p.occupation # => 'Rubyist'
p.email = 'abc@def.com'
puts p.email # => 'abc@def.com'
#p['awesome'] # => NoMethodError

p = Person.new(:name => "Awesome Guy")
puts p.name # => "Awesome Guy"
puts p.occupation # => "Rubyist"