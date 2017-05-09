class Friend < ActiveRecord::Base
  belongs_to :userA, :class_name => "User"
  belongs_to :userB, :class_name => "User"
end
