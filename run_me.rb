require 'pry'
require 'pp'
require 'piperator'
require_relative 'reader'
require_relative 'parser'
require_relative 'processor'

pp Piperator::Pipeline
  .pipe(Reader)
  .pipe(Parser)
  .pipe(Processor.method(:call).curry.('Events.TrafficCar'))
  .call('test_data.txt')
  .to_a
