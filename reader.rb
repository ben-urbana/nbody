require "gosu"
require "./body"
require "./nbody"

module Reader
	def Reader.read(filename)
		File.open("./simulations/#{filename}") do |a|
			a.each_line.with_index do |line, i|
				if i == 0
					amount_of_bodies = line
				elsif i == 1
					radius = line
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
		return Simulation.new(amount_of_bodies, radius, bodies)
	end
end