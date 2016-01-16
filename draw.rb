require 'graphics'
require './vec'

RADIUS = 5
class DLA
  attr_reader :drifting, :stopped
  def initialize
    @drifting = []
    400.times do
      @drifting << drifting_particle
    end

    @stopped = [ Particle.new( Vec2.new(10, 10) ) ]
  end

  def drifting_particle_at_edges
    position = Vec2.random_positive.map(&:round) * 500
    velocity = Vec2.random * 5
    Particle.new(position, velocity)
  end

  def drifting_particle
    position = Vec2.random_positive * 500
    velocity = Vec2.random
    Particle.new(position, velocity+Vec2.new(-2,-2))
  end

  def drip
    @drifting << drifting_particle_at_edges
  end

  def drifting_intersects_stopped? drifter
    stopped.any? do |p|
      drifter.pos.distance_from(p.pos) <= (RADIUS*2)
    end
  end

  def update
    sleep if drifting.count == 0

    stopped.each do |p|
      p.age += 1
    end

    drifting.each do |drifter|
      if drifting_intersects_stopped? drifter
        stopped << drifter
        drifting.delete drifter
      else
        drifter.step
      end
    end
  end
end

class DLASimulation < Graphics::Simulation
  WINSIZE = 500

  attr_reader :sim
  def initialize
    super WINSIZE, WINSIZE, 8, "DLA"
    @sim = DLA.new
  end

  def update dt
    sim.update
  end

  def draw dt
    clear :white

    sim.stopped.each do |p|
      px = p.pos.x
      py = p.pos.y
      circle px, py, RADIUS, :black, :filled
    end

    sim.drifting.each do |p|
      px = p.pos.x
      py = p.pos.y
      circle px, py, RADIUS, :black
    end
  end
end

DLASimulation.new.run
