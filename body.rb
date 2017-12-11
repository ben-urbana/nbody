require "gosu"

class Body

	attr_accessor :x, :y, :vel_x, :vel_y, :mass

	T = 25000
	G = 6.67408 * 10 ** (-11)

	def initialize(x, y, vel_x, vel_y, mass, image, window)
		@x = x.to_f
		@y = y.to_f
		@vel_x = vel_x.to_f
		@vel_y = vel_y.to_f
		@mass = mass
		@image = image
		@window = window
	end

	def update
		

		@x += @vel_x
		@y += @vel_y
	end

	def compare(other_body)
		
		@r = Math.sqrt((x - other_body.x) ** 2 + (y - other_body.y) ** 2)
		@dx = x - other_body.x
		@dy = y - other_body.y

		@F = (G * @mass * other_body.mass) / @r * @r
		@Fx = @F * (@dx / @r)
		@Fy = @F * (@dy / @r)
		@a = @F / mass
		@vel_y = (@a * T) / 2.50e13
		@vel_x = (@a * T) / 2.50e13

	end

	def draw
		@image.draw(x, y, 1)
	end
end