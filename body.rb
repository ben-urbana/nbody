require "gosu"

class Body

	DT = 25000
	G = 6.67408E-11

	attr_accessor :x, :y, :vel_x0, :vel_y0, :mass, :F, :ax, :ay, :x_coord, :y_coord

	def initialize(x, y, vel_x0, vel_y0, mass, image, planet_radius, vel_z0)
		@x = x.to_f
		@y = y.to_f
		@vel_x = vel_x0.to_f
		@vel_y = vel_y0.to_f
		@mass = mass.to_f
		@image = Gosu::Image.new("images/#{image}", tileable: true)
		@pic = image
		@planet_radius = planet_radius.to_f
		@vel_z = vel_z0.to_f
		@scale = 1.0
		@F = 0.0
		@Fx = 0.0
		@Fy = 0.0
		@Fz = 0.0
	end



	def compare(bodies)

		bodies.each do |other_body|
			next if other_body == self
			@dx = other_body.x - @x
			@dy = other_body.y - @y
			@r = Math.sqrt(@dx ** 2 + @dy ** 2)

			@F = (G * @mass * other_body.mass) / (@r ** 2)
			@Fx += @F * @dx / @r
			@Fy += @F * @dy / @r
			@Fz += @F

			if (@radius + other_body.radius) >= @dx || (@radius + other_body.radius) >= @dy #collision code
				Body.new(@x, @y, rand(0...@vel_x), rand(0...@vel_y), @mass / 2, @image, @planet_radius / 2, rand(0...@vel_z))
				@mass = @mass / 2
				@planet_radius = @planet_radius / 2
				@vel_x = rand(0...@vel_x)
				@vel_y = rand(0...@vel_y)
				@vel_z = rand(0...@vel_z)

				Body.new(other_body.x, other_body.y, rand(0...other_body.vel_x), rand(0...other_body.vel_y), other_body.mass / 2, other_body.image, other_body.planet_radius / 2, rand(0...other_body.vel_z))
				other_body.mass = other_body.mass / 2
				other_body.planet_radius = other_body.planet_radius / 2
				other_body.vel_x = rand(0...other_body.vel_x)
				other_body.vel_y = rand(0...other_body.vel_y)
				other_body.vel_z = rand(0...other_body.vel_z)
			end
		end
		move
	end

	def move
		@ax = @Fx / @mass
		@ay = @Fy / @mass
		@az = @Fz / @mass

		@vel_y += @ay * DT
		@vel_x += @ax * DT
		@vel_z += @az * DT

		@Fx = 0.0
		@Fy = 0.0
		@Fz = 0.0
		
		@x += @vel_x * DT
		@y += @vel_y * DT
		@scale = @vel_z
	end


	def draw(radius)
		@x_coord = 320 * @x / radius + 320 - (@image.width / 2.0)
		@y_coord = -320 * @y / radius + 320 - (@image.height / 2.0)
		@image.draw(@x_coord, @y_coord, 1, @scale, @scale)

		# @x = @x_coord * 2.50e11 / 320 - 320
		# @y = @y_coord * 2.50e11 / 320 - 320
	end
end
