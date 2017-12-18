require "gosu"

class Body

	attr_accessor :x, :y, :vel_x, :vel_y, :mass

	T = 25000
	G = 6.67408 * 10 ** (-11)

	def initialize(x, y, vel_x, vel_y, mass, image)
		@x = x.to_f
		@y = y.to_f
		@vel_x = vel_x.to_f
		@vel_y = vel_y.to_f
		@mass = mass.to_f
		@image = Gosu::Image.new("images/#{image}", tileable: true)
	end



	def update


		@x += @vel_x
		@y += @vel_y
		print @x_coord, "\n"

		
	end

	def compare(bodies)
		bodies.each do |other_body|
			next if other_body == self
			@r = Math.sqrt((@x - other_body.x) ** 2 + (@y - other_body.y) ** 2)
			@dx = @x - other_body.x
			@dy = @y - other_body.y

			@F = (G * @mass * other_body.mass) / (@r * @r)
			@Fx = @F * (@dx / @r)
			@Fy = @F * (@dy / @r)
			@a = @F / mass
			@vel_y = (@a * T)
			@vel_x = (@a * T)
			@F = 0.0
		end
		self.update
	end

	def draw
		@x_coord = 320 * @x / 2.50e11 + 320
		@y_coord = 320 * @y / 2.50e11 + 320
		@image.draw(@x_coord, @y_coord, 1)
	end
end