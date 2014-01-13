class Listing < ActiveRecord::Base
	scope :recent, -> { where('created_at >= ?', Date.today - 30) }
	scope :virtual, -> { where(virtual: true) }
	scope :in_person, -> { where(in_person: true) }
	has_many :notifications
	belongs_to :user
	belongs_to :subtopic
	geocoded_by :address
	
	after_validation :geocode, :if => :address_changed?

	def self.search_for(query)
		where('title LIKE :query', query: "%#{query}%")
	end
end

