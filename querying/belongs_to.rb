# Look at the following tables for reference...
class Person < ActiveRecord::Base
  belongs_to :role
end

class Role < ActiveRecord::Base
  has_many :people
end

# instead of Person.all.select { |person| person.role.billable? }
# use join i.e. 
Person.all.joins(:role)
# and filter i.e. 
Person.all.joins(:role).where(roles: { billable: true })

# let's move the logic to the role method i.e. 
class Role < ActiveRecord::Base 
  def self.billable 
    where(billable: true)
  end
end

# now we can use merge when querying people i.e. 
Person.joins(:role).merge(Role.billable)

# now we can package our complete solution i.e.
class Person < ActiveRecord::Base 
  def self.billable 
    joins(:role).merge(Role.billable)
  end
end

# Now we can retreive all billable people i.e. 
Person.billable