class Worklog < ActiveRecord::Base
  include Redmine::SafeAttributes
  
  unloadable
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  
  TYPEE = {"day" => 0,"week" => 1, "month" => 2}
  
  def self.typee_collection
      TYPEE.collect { |s| [s[0], s[1]]}
  end
  
end
