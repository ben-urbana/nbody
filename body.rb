require "gosu"

class Body

	DT = 25000
	G = 6.67408E-11

	attr_accessor :x, :y, :vel_x0, :vel_y0, :mass, :F, :ax, :ay, :x_coord, :y_coord

	def initialize(x, y, vel_x0, vel_y0, mass, image)
		@x = x.to_f
		@y = y.to_f
		@vel_x = vel_x0.to_f
		@vel_y = vel_y0.to_f
		@mass = mass.to_f
		@image = Gosu::Image.new("images/#{image}", tileable: true)
		@pic = image
		@F = 0.0
		@Fx = 0.0
		@Fy = 0.0

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
			
			
			
		end
		move
	end

	def move
		@ax = @Fx / @mass
		@ay = @Fy / @mass

		@vel_y += @ay * DT
		@vel_x += @ax * DT

		


		

		@Fx = 0.0
		@Fy = 0.0
		

		@x += @vel_x * DT
		@y += @vel_y * DT

		

		
	end


	def draw(radius)
		@x_coord = 320 * @x / radius + 320 - (@image.width / 2.0)
		@y_coord = -320 * @y / radius + 320 - (@image.height / 2.0)
		@image.draw(@x_coord, @y_coord, 1)

		# @x = @x_coord * 2.50e11 / 320 - 320
		# @y = @y_coord * 2.50e11 / 320 - 320
	end
end
