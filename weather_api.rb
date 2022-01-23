require 'net/http'    
require 'json'
require 'date'


apiKey = "jzVTjBueGR9BktXiEoAKup9yXmGH7O2M"
if ARGV.first.nil?
  puts "No Location Provided!"
  exit
else
  locationKey = ARGV.first.to_s
end
uri = URI("http://dataservice.accuweather.com/currentconditions/v1/#{locationKey}?apikey=#{apiKey}&details=true")

res = Net::HTTP.get(uri)
data = JSON.parse(res)

begin
  if data.is_a?(Array) # Check if the response is an error or not
    response = data[0]
    percip = response['PrecipitationType'].nil? ? "None" : "#{response['PrecipitationType']}"
    location = response['Link'].split('za/')[1].split('/')[0].split('-').map(&:capitalize).join(' ')
    date = Date.parse(response['LocalObservationDateTime']).strftime("%Y-%m-%d %H:%M")
    puts "Weather For #{location} \nTemperature: #{response['Temperature']['Metric']['Value']}ºC \nRain: #{percip} \nHumidity: #{response['RelativeHumidity']}% \nWind:  #{response['Wind']['Speed']['Metric']['Value']}km/h (#{response['Wind']['Direction']['English']}) \n\n\nUpdated at: #{date}"
  elsif data['Code'] == "ServiceUnavailable"
    puts "Uh Oh, Accuweather Service Unavailable (API Usage Cap)"
  else
    puts "Accuweather Sercice... Something else went wrong"
  end
rescue => exception
  puts "Exception has been raised! #{exception}"
end