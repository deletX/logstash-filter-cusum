# encoding: utf-8
require "logstash/filters/base"

# This  filter will take make a cumulative sum based on given add_values dictionary.
# The first value will be taken from the initial_values dictionary. The filter
# then takes the stored value (or initial value if there's no stored value yet) and adds
# what is in the add_values dictionary. If there is no add_value 0 is added.
# 
# If there is no initial_value for a given field 0 will be used
#
# Usage:
#
# filter {
#   cusum{
#     fields => ["apples","bananas"]
#     add_values => {
#         "apples"  => "%{[apples_to_add]}"
#         "bananas" => "%{[bananas_to_add]}"
#       }
#     initial_values => {
#         "apples"  => "0"
#         "bananas" => "%{[default_bananas]}"
#       }
#   }
# }

class LogStash::Filters::Cusum < LogStash::Filters::Base
  config_name "cusum"

  # Define filter values: fields, add_values and initial_values
  config :fields, :validate => :array, :required => true

  config :add_values, :validate => :hash, :required => false

  config :initial_values, :validate => :hash, :required => false 

  public
  def register
    @cusum = Hash.new
    @logger.debug? && @logger.debug("[cusum] Creating locally stored hash")
  end # def register

  public
  def filter(event)
    @logger.debug? && @logger.debug("[cusum] Applying cusum filter")

    @fields.each do |field|
      # take the value from the map
      val = @cusum[field]

      if val.nil?
        if @initial_values.nil? # if there is no initial_values we set current value to 0
          val = 0
        else # if there is no value stored yet set it to the starting value. If there is no given starting value, our own default is 0
          val = @initial_values[field].nil? ? 0 : event.sprintf(@initial_values[field]).to_i #NO CHECK ON  validity :'( 
        end
      end # val.nil?

      @logger.debug? && @logger.debug("[cusum] cusum value for #{field} was #{val}")

      
      if @add_values.nil? # If there is no add_values we set to_add to 0 (no change)
        to_add = 0
      else # Take the to_add value from values to add. If no value is specified we add 0 (no change)
        to_add = @add_values[field].nil? ? 0 : event.sprintf(@add_values[field]).to_i #NO CHECK ON  validity :'(     
      end
      
      @logger.debug? && @logger.debug("[cusum] value to add for #{field} is #{to_add}")

      # Store in the map the sum
      @cusum[field] = val + to_add

      @logger.debug? && @logger.debug("[cusum] cusum value for #{field} isn now #{@cusum[field]}")

      # Set on the event the field with the cusum value. Overriding any current value
      event.set(field,@cusum[field])
      
      @logger.debug? && @logger.debug("[cusum] set event field #{field} to #{@cusum[field]}")

    end # @fields.each do
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Cusum
