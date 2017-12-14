require 'gosu'
require_relative "z_order"

class Simulation

	attr_accessor :amount_of_bodies, :radius, :bodies

	def initialize(amount_of_bodies, radius, bodies)
		@amount_of_bodies = amount_of_bodies
		@radius = radius
		@bodies = bodies
	end



	def convert(x, y, img)
		return [((320 * x) / radius) + 320 - (img.width / 2), ((320 * y) / radius) + 320 - (img.height / 2) ]
	end

	def update
		bodies.each do |body|
			body.compare(bodies)
		end
	end
end