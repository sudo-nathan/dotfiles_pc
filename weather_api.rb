require 'net/http'    
require 'json'

apiKey = "jzVTjBueGR9BktXiEoAKup9yXmGH7O2M"
locationKey = "304827"
uri = URI("http://dataservice.accuweather.com/currentconditions/v1/#{locationKey}?apikey=#{apiKey}&details=true")

res = Net::HTTP.get(uri)
data = JSON.parse(res)

if data.is_a?(Array) # Check if the response is an error or not
  response = data[0]
  percip = response['PrecipitationType'].nil? ? "None" : "#{response['PrecipitationType']}"
  puts "Weather for Port Elizabeth:"
  puts "Temprature: #{response['Temperature']['Metric']['Value']}ºC \nRain: #{percip} \nHumidity: #{response['RelativeHumidity']}% \nWind:  #{response['Wind']['Speed']['Metric']['Value']}km/h (#{response['Wind']['Direction']['English']})"
elsif data['Code'] == "ServiceUnavailable"
  puts "Uh Oh, Accuweather Service Unavailable (API Usage Cap)"
else
  puts "Something else went wrong..."
end