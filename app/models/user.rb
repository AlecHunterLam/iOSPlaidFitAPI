class User < ApplicationRecord
  # Constants
  ROLES = [['Player', :player], ['Athletic Trainer', :athletic_trainer], ['Coach',:coach], ['Guest', :guest]]
  MAJORS = [['Information Systems', :is], ['Computer Science', :cs], ['Other', :other]]

  # Relationships
  has_many :rostered
  has_many :teams, through: :rostered
  has_many :surveys
  has_many :events
  has_many :earned_badges
  has_many :badges, through: :earned_badges
  has_many :notifications

  # Scopes


  # Validations
  validates_presence_of :andrew_id, :email, :major, :role, :active
  # need to know format of andrew id's to write regex for it
  validates_inclusion_of :major, in: MAJORS.map{|key, value| value}, message: "is not a major in the system"
  validates_inclusion_of :role, in: ROLES.map{|key, value| value}, message: "is not a valid role"
  validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
  validates :email, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format email" }
  validate :validate_andrew_id



  # Methods
  private
  def validate_andrew_id
    input_andrew_id = self.andrew_id
    all_andrew_ids = User.all.map{ |u| u.andrew_id }
    all_andrew_ids.each do |current_id|
      if current == input_andrew_id
        return false
      end
    return true
   end

end
