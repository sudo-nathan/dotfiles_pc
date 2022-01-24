require 'net/http'
require 'date'
require 'json'

@urls = [
  {'name'=> "github", 'url'=> "https://www.githubstatus.com/api/v2/summary.json"},
  {'name'=> "circleCI", 'url'=> "https://status.circleci.com/api/v2/summary.json"},
  {'name'=> "heroku", 'url'=> "https://status.heroku.com/api/v4/current-status"},
  {'name'=> "figma", 'url'=> "https://status.figma.com/api/v2/summary.json"},
]

@github_whitelist = %w(GitOperations APIRequests Issues PullRequests GitHubActions GitHubPackages Codespaces)
@cci_whitelist = %w(CircleCIDependencies CircleCIWebhooks CircleCIUI Runner UpstreamServices MachineJobs macOSJobs WindowsJobs DockerJobs)

def start
  puts "Hello, Gathering Information, Please Wait..."
  send_requests
  puts "All Done!"
end

def send_requests
  @urls.each do |req|
    request = Net::HTTP.get(URI(req['url']))
    response = JSON.parse(request)
    puts filter_data(response, req['name'], req['url'])
  end
end

def filter_data(data, type, url)
  link = URI(url).hostname
  out = []
  case type
  when 'heroku'
    data = data['status']
    generate_header(type, out, false, data)
    data.map{|r| 
      stat = r['status'] == "green"? "\u001b[32mAll Systems Operational\u001b[37m" : "Experiencing Problems"
      out.push("#{r['system']}: #{stat}")
    }
    out.push("Visit https://#{link} for detailed info")
    puts out.join("\n")
  when 'circleCI'
    generate_header(type, out, true, data)
    data['components'].map{|r|
      if @cci_whitelist.include?(r['name'].split(' ').join(''))
        out.push("#{r['name']}: #{statuspage_opts(r['status'])}")
      end
    }
    out.push("Visit https://#{link} for detailed info")
    puts out.join("\n")
  when 'github'
    generate_header(type, out, true, data)
    data['components'].map{|r|
      if @github_whitelist.include?(r['name'].split(' ').join(''))
        out.push("#{r['name']}: #{statuspage_opts(r['status'])}")
      end
    }
    out.push("Visit https://#{link} for detailed info")
    puts out.join("\n")
  when 'figma' 
    generate_header(type, out, true, data)
    data['components'].map{|r|
      out.push("#{r['name']}: #{statuspage_opts(r['status'])}")
    }
    out.push("Visit https://#{link} for detailed info")
    puts out.join("\n")
  else
    puts "I don't know what to do with that data!"
    return
  end
end

def statuspage_opts(input)
  case input
  when "operational" 
    "\u001b[32mAll Systems Operational\u001b[37m"
  when "degraded_performance"
    "\u001b[33mDegraded Performance\u001b[37m"  
  when "partial_outage"
    "\u001b[33mPartial Outage\u001b[37m"
  when "major_outage"
    "\u001b[31mMajor Service Outage\u001b[37m"
  end
end

def statuspage_main input
  case input
  when "none"
    "\u001b[32mAll Systems Operational\u001b[37m"
  when "minor"
    "\u001b[33mMinor Outage\u001b[37m"  
  when "major"
    "\u001b[33mMajor outage\u001b[37m"  
  when "critical"
    "\u001b[31mCritical Outage\u001b[37m"
  end
end

def line
  "====================================================="
end

def generate_header name, var, oas, data
  var.push(line)
  var.push("#{name.capitalize} Status Information")
  var.push(line)
  if oas
    var.push("Over-All Status: #{statuspage_main(data['status']['indicator'])}")
    var.push(line)
    var.push("-- Components --")
  else
    var.push("-- Components --")
  end
end

start