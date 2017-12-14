require "gosu"
require "./z_order"
require "./body"
require "./simulation"


class NbodySimulation < Gosu::Window

	def initialize
    	super(640, 640, false)
    	self.caption = "NBody simulation"
    	self.read("planets.txt")
    end

  	def read(file)
  		bodies = []
  		amount_of_bodies = 0
  		radius = 0
		File.open("./simulations/#{file}") do |a|
			a.each_line.with_index do |line, i|
				if i == 0
					amount_of_bodies = line
				elsif i == 1
					@radius = line
				else
					pieces = line.gsub(/\s+/m, ' ').strip.split(" ")
					if pieces[0] == nil
						next
					end
					if pieces[0] == "Creator"
						break
					end
					bodies.push(Body.new(pieces[0], pieces[1], pieces[2], pieces[3], pieces[4], pieces[5]))
				end
			end
		end
		@simulation = Simulation.new(amount_of_bodies, radius, bodies)
	end

	def update
  		@simulation.update
  	end

  	def draw
    	@background_image.draw(0, 0, ZOrder::Background)
    	@simulation.draw
  	end

  	def button_down(id)
    	close if id == Gosu::KbEscape
  	end
end

window = NbodySimulation.new
window.show
