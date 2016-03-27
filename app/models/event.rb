class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
  validate :start_must_be_before_end_time


  def self.upcoming_events
    where("ends_at > ? AND published = ?", DateTime.now, true)
  end

  def self.search(query)
    where("name ILIKE ?", "%#{query}%").where('published = ?', true)
  end
  private

  def start_must_be_before_end_time
    errors.add(:starts_at, "must be before end time") unless
    starts_at <= ends_at
  end
end