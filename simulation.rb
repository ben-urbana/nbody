require 'gosu'
require_relative "z_order"

class Simulation

	attr_accessor :amount_of_bodies, :radius, :bodies

	def initialize(amount_of_bodies, radius, bodies)
		@amount_of_bodies = amount_of_bodies
		@radius = radius
		@bodies = bodies
	end

	def update
		bodies.each do |body|
			body.compare(bodies)
		end
	end

	def draw
		bodies.each do |body|
			body.draw(@radius)
		end
	end
end
