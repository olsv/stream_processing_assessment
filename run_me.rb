require 'pry'
require 'pp'
require 'piperator'
require_relative 'reader'
require_relative 'parser'
require_relative 'processor'
require_relative 'payload'

pp Piperator::Pipeline
  .pipe(Reader.method(:call).curry.('--myboundary'))
  .pipe(Parser.method(:call).curry.(Payload))
  .pipe(Processor.method(:call).curry.('Events.TrafficCar'))
  .call('test_data.txt')
  .to_a
