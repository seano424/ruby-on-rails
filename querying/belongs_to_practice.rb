# Look at the following tables for reference...
class Person < ActiveRecord::Base
  belongs_to :role
end

class Role < ActiveRecord::Base
  has_many :people
end

Person.all.select { |person| person.role.billable? }

# Role.where(billable: true)
class Role < ActiveRecord::Base 
  def self.billable 
    where(billable: true)
  end
end

# Person.joins(:role).merge(Role.billable)
class Person < ActiveRecord::Base 
  def self.billable 
    joins(:role).merge(Role.billable)
  end
end

