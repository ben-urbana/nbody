require "gosu"
require_relative "z_order"
require_relative "body"
require_relative "reader"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    
    @the_planets = Reader.read("simulations/planets.txt")

  end

  def update
  	@body4.compare(@body)
  	@body.compare(@body4)

  	self.caption = @body4.x, + @body4.y, + @body4.vel_x, + @body4.vel_y


  	@body.update
  	@body2.update
  	@body3.update
  	@body4.update
  	@body5.update
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @body.draw
    @body2.draw
    @body3.draw
    @body4.draw
    @body5.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show