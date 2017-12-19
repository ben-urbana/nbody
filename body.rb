require "gosu"

class Body

	attr_accessor :x, :y, :vel_x, :vel_y, :mass, :F, :ax, :ay, :x_coord, :y_coord

	def initialize(x, y, vel_x, vel_y, mass, image)
		@x = x.to_f
		@y = y.to_f
		@vel_x = vel_x.to_f
		@vel_y = vel_y.to_f
		@mass = mass.to_f
		@image = Gosu::Image.new("images/#{image}", tileable: true)
		@F = 0.0
		@vel_y0 = 0.0
		@vel_x0 = 0.0
		@Fx = 0.0
		@Fy = 0.0
	end



	def compare(bodies)

		@time = 25000
		@grav = 6.67408 * 10e-11

		bodies.each do |other_body|
			next if other_body == self
			@dx = other_body.x - @x
			@dy = other_body.y - @y
			@r = Math.sqrt(@dx ** 2 + @dy ** 2)

			@F = (@grav * @mass * other_body.mass) / (@r ** 2)
			@Fx += @F * (@dx / @r)
			@Fy += @F * (@dy / @r)
			@vel_y0 = @vel_y
			@vel_x0 = @vel_x
			@ax = @Fx / @mass
			@ay = @Fy / @mass
			
			@vel_y = @ay * @time + @vel_y0
			@vel_x = @ax * @time + @vel_x0

			@Fx = 0.0
			@Fy = 0.0

			@x += @vel_x * @time + @vel_x0
			@y += @vel_y * @time + @vel_y0

						

		end
	end

	def draw(radius)
		@x_coord = 320 * @x / radius + 320 - (@image.width / 2)
		@y_coord = 320 * @y / radius + 320 - (@image.height / 2)
		@image.draw(@x_coord, @y_coord, 1)
		# @x = @x_coord * 2.50e11 / 320 - 320
		# @y = @y_coord * 2.50e11 / 320 - 320
	end
end
