class User < ApplicationRecord
  # callbacks

  # downcase the andrew_id before validation
  before_validation :downcase_andrew_id, :reformat_phone


  # Constants
  ROLES = [['Player', :player], ['Athletic Trainer', :athletic_trainer], ['Coach',:coach], ['Guest', :guest]]
  MAJORS = [['Information Systems', :is], ['Computer Science', :cs], ['Other', :other], ['Engineering',:engineering], ['Business', :business]]
  CLASSES = [['Freshman', :freshman], ['Sophomore', :sophomore], ['Junior', :junior], ['Senior', :senior], ['Other', :other]]

  # Relationships
  has_many :team_assignments
  has_many :teams, through: :team_assignments
  has_many :player_calculations
  has_many :surveys
  has_many :events
  has_many :earned_badges
  has_many :badges, through: :earned_badges
  has_many :notifications

  # Scopes
  scope :by_role,       ->  (role)         { where("role == ?", role) }
  scope :by_email,      ->  (email)        { where("email == ?", email) }
  scope :by_andrew_id,  ->  (andrew_id)    { where("andrew_id == ?", andrew_id) }
  scope :by_major,      ->  (major)        { where("major == ?", major) }

  # Validations
  validates_presence_of :andrew_id, :email, :major, :role, :active
  # need to know format of andrew id's to write regex for it
  validates_inclusion_of :major, in: MAJORS.map{|key, value| key}, message: "is not a major in the system"
  validates_inclusion_of :role, in: ROLES.map{|key, value| key}, message: "is not a valid role"
  validates_inclusion_of :year, in: CLASSES.map{|key, value| key}, message: "is not a valid year"
  validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
  validates :email, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format email" }
  validates :andrew_id, format: { with: /\A[a-z0-9]+\z/, message: "is not a valid format for an Andrew ID" }
  validates_uniqueness_of :andrew_id

  def name
    first_name + " " + last_name
  end

  # Methods
  private

  def reformat_phone
    phone = self.phone.to_s  # change to string in case input as all numbers
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.phone = phone       # reset self.phone to new string
  end

  # ensure that andrew ID is all lowercase before validation
  def downcase_andrew_id
    self.andrew_id.downcase!
  end

end
