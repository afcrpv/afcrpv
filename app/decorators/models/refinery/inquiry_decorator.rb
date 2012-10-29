Refinery::Inquiries::Inquiry.class_eval do
  include Humanizer
  attr_accessor :bypass_humanizer
  attr_accessible :humanizer_answer, :humanizer_question_id

  if Rails.env.production?
    require_human_on :create, :unless => :bypass_humanizer
  end
end
