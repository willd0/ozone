class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    require '/railsfriends/ozone/.api_key.rb'
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=75070&distance=0&API_KEY='+ $api_key
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    
    #Check for empty return result
    if @output.empty?
      @final_output = "Error"
    elsif !@output
      @final_output = "Error"
    else
      @final_output = @output[0]["AQI"]
    end

    if @final_output == "Error"
      @api_color = "silver"
    elsif @final_output <= 50
      @api_color = "green"
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "yellow"
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "orange"
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "red"
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "purple"
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "maroon"
    end
      
      
  end
end
