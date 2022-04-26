class Url < ApplicationRecord
	validates :url, uniqueness: true, presence: true
	validates_format_of :short_code, :with => /^[0-9a-zA-Z_]{6}$/, presence: true,:multiline => true
end
