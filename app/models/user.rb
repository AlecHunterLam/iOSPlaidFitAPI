
class User < ApplicationRecord
  require 'bcrypt'
  # callbacks

  # downcase the andrew_id before validation
  before_validation :downcase_andrew_id, :reformat_phone

  # token authentication
  has_secure_password




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
  scope :active,        ->                 { where(active: true) }
  scope :by_role,       ->  (role)         { where("role == ?", role) }
  scope :by_team,       ->  (team_id)      { joins(:team_assignments).where("team_assignments.team_id == ?", team_id) }
  scope :by_year,       ->  (year)         { where("year == ?", year) }
  scope :by_andrew_id,  ->  (andrew_id)    { where("andrew_id == ?", andrew_id) }
  scope :by_major,      ->  (major)        { where("major == ?", major) }

  # Validations
  validates_presence_of :andrew_id, :email, :role
  validates :active, :inclusion => { :in => [true, false] }
  validate :presence_of_if_player #, message: "Player's must have both a year and major"
  # need to know format of andrew id's to write regex for it
  validates_inclusion_of :major, in: MAJORS.map{|key, value| key}, message: "is not a major in the system", allow_blank: true
  validates_inclusion_of :role, in: ROLES.map{|key, value| key}, message: "is not a valid role"
  validates_inclusion_of :year, in: CLASSES.map{|key, value| key}, message: "is not a valid year", allow_blank: true
  validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
  validates :email, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format email" }
  validates :andrew_id, format: { with: /\A[a-z0-9]+\z/, message: "is not a valid format for an Andrew ID" }
  validates_uniqueness_of :andrew_id #, message: "must be a valid Andrew ID"

  # token authentication
  validates_uniqueness_of :email, allow_blank: true
  validates_presence_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, minimum: 6, message: "must be at least 6 characters long", allow_blank: true
  validates_uniqueness_of :api_key

  # Callback for token authentication
  before_create :generate_api_key

  def name
    first_name + " " + last_name
  end

  # login by andrew_id
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  # get a random api key
  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while User.exists?(api_key: self.api_key)
  end

  # Methods
  private

  def presence_of_if_player
    if self.role.nil?
      return false
    else
      if self.role == "Player" && (self.year.nil? || self.major.nil?)
        return false
      else
        return true
      end
    end
  end

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
