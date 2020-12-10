# Use the tables as reference
class Person < ActiveRecord::Base
  belongs_to :location
  belongs_to :role
end

class Region < ActiveRecord::Base 
  has_many :locations
end

class Location < ActiveRecord::Base
  has_many :people
  belongs_to :region
end

class Role < ActiveRecord::Base
  has_many :people
end


class Location < ActiveRecord::Base 
  def self.billable 
    joins(:people :role).where(roles: { billable.true }).distinct
  end

  def self.by_region_and_location 
    joins(:region).merge(Region.order(:name)).order(:name)
  end
end

Location.billable.by_region_and_location //throws error 
Location.from(Location.billable, :locations).by_region_and_location






