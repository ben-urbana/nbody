require "gosu"
require "./z_order"
require "./body"
require "./simulation"


class NbodySimulation < Gosu::Window

  def initialize
      super(640, 640, false)
      
      @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
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
          radius = line.to_f
        else
          pieces = line.gsub(/\s+/m, ' ').strip.split(" ")
          if pieces[0] == nil
            next
          end
          if pieces[0] == "Creator"
            break
          end
          bodies.push(Body.new(pieces[0].to_f, pieces[1].to_f, pieces[2].to_f, pieces[3].to_f, pieces[4].to_f, pieces[5], pieces[6].to_f, pieces[7].to_f))

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
