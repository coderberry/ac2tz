require 'rubygems'
require 'sinatra'

def to_xml(ac)
  if ac.nil?
    xml = "<result>Does not exist.</result>"
  else
    xml = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>    
<result>
  <area_code>#{ac[0]}</area_code>
  <state>#{ac[1]}</state>
  <time_zone>#{ac[2].gsub("&","&#38;")}</time_zone>
</result>
EOF
  end
  return xml
end

area_codes = Hash.new

[
  ["201", "NJ", "Eastern Time (US & Canada)"], ["310", "CA", "Pacific Time (US & Canada)"], ["438", "QC", "Eastern Time (US & Canada)"], ["606", "KY", "Eastern Time (US & Canada)"], ["732", "NJ", "Eastern Time (US & Canada)"], ["860", "CT", "Eastern Time (US & Canada)"],
  ["202", "DC", "Eastern Time (US & Canada)"], ["312", "IL", "Central Time (US & Canada)"], ["440", "OH", "Eastern Time (US & Canada)"], ["607", "NY", "Eastern Time (US & Canada)"], ["734", "MI", "Eastern Time (US & Canada)"], ["862", "NJ", "Eastern Time (US & Canada)"],
  ["203", "CT", "Eastern Time (US & Canada)"], ["313", "MI", "Eastern Time (US & Canada)"], ["443", "MD", "Eastern Time (US & Canada)"], ["608", "WI", "Central Time (US & Canada)"], ["740", "OH", "Eastern Time (US & Canada)"], ["863", "FL", "Eastern Time (US & Canada)"],
  ["204", "MB", "Central Time (US & Canada)"], ["314", "MO", "Central Time (US & Canada)"], ["450", "QC", "Eastern Time (US & Canada)"], ["609", "NJ", "Eastern Time (US & Canada)"], ["754", "FL", "Eastern Time (US & Canada)"], ["864", "SC", "Eastern Time (US & Canada)"],
  ["205", "AL", "Central Time (US & Canada)"], ["315", "NY", "Eastern Time (US & Canada)"], ["469", "TX", "Central Time (US & Canada)"], ["610", "PA", "Eastern Time (US & Canada)"], ["757", "VA", "Eastern Time (US & Canada)"], ["865", "TN", "Eastern Time (US & Canada)"],
  ["206", "WA", "Pacific Time (US & Canada)"], ["316", "KS", "Central Time (US & Canada)"], ["470", "GA", "Eastern Time (US & Canada)"], ["612", "MN", "Central Time (US & Canada)"], ["760", "CA", "Pacific Time (US & Canada)"], ["867", "YT", "Pacific Time (US & Canada)"],
  ["207", "ME", "Eastern Time (US & Canada)"], ["317", "IN", "Eastern Time (US & Canada)"], ["478", "GA", "Eastern Time (US & Canada)"], ["613", "ON", "Eastern Time (US & Canada)"], ["762", "GA", "Eastern Time (US & Canada)"], ["870", "AR", "Central Time (US & Canada)"],
  ["208", "ID", "Mountain Time (US & Canada)"], ["318", "LA", "Central Time (US & Canada)"], ["479", "AR", "Central Time (US & Canada)"], ["614", "OH", "Eastern Time (US & Canada)"], ["763", "MN", "Central Time (US & Canada)"], ["878", "PA", "Eastern Time (US & Canada)"],
  ["209", "CA", "Pacific Time (US & Canada)"], ["319", "IA", "Central Time (US & Canada)"], ["480", "AZ", "Mountain Time (US & Canada)"], ["615", "TN", "Central Time (US & Canada)"], ["765", "IN", "Eastern Time (US & Canada)"], ["901", "TN", "Central Time (US & Canada)"],
  ["210", "TX", "Central Time (US & Canada)"], ["320", "MN", "Central Time (US & Canada)"], ["484", "PA", "Eastern Time (US & Canada)"], ["616", "MI", "Eastern Time (US & Canada)"], ["769", "MS", "Central Time (US & Canada)"], ["902", "NS", "Eastern Time (US & Canada)"],
  ["212", "NY", "Eastern Time (US & Canada)"], ["321", "FL", "Eastern Time (US & Canada)"], ["501", "AR", "Central Time (US & Canada)"], ["617", "MA", "Eastern Time (US & Canada)"], ["770", "GA", "Eastern Time (US & Canada)"], ["903", "TX", "Central Time (US & Canada)"],
  ["213", "CA", "Pacific Time (US & Canada)"], ["323", "CA", "Pacific Time (US & Canada)"], ["502", "KY", "Central Time (US & Canada)"], ["618", "IL", "Central Time (US & Canada)"], ["772", "FL", "Eastern Time (US & Canada)"], ["904", "FL", "Eastern Time (US & Canada)"],
  ["214", "TX", "Central Time (US & Canada)"], ["325", "TX", "Central Time (US & Canada)"], ["503", "OR", "Pacific Time (US & Canada)"], ["619", "CA", "Pacific Time (US & Canada)"], ["773", "IL", "Central Time (US & Canada)"], ["905", "ON", "Eastern Time (US & Canada)"],
  ["215", "PA", "Eastern Time (US & Canada)"], ["330", "OH", "Eastern Time (US & Canada)"], ["504", "LA", "Central Time (US & Canada)"], ["620", "KS", "Central Time (US & Canada)"], ["774", "MA", "Eastern Time (US & Canada)"], ["906", "MI", "Eastern Time (US & Canada)"], 
  ["216", "OH", "Eastern Time (US & Canada)"], ["331", "IL", "Central Time (US & Canada)"], ["505", "NM", "Mountain Time (US & Canada)"], ["623", "AZ", "Mountain Time (US & Canada)"], ["775", "NV", "Pacific Time (US & Canada)"], ["907", "AK", "Alaska"], 
  ["217", "IL", "Central Time (US & Canada)"], ["334", "AL", "Central Time (US & Canada)"], ["506", "NB", "Eastern Time (US & Canada)"], ["626", "CA", "Pacific Time (US & Canada)"], ["778", "BC", "Pacific Time (US & Canada)"], ["908", "NJ", "Eastern Time (US & Canada)"],
  ["218", "MN", "Central Time (US & Canada)"], ["336", "NC", "Eastern Time (US & Canada)"], ["507", "MN", "Central Time (US & Canada)"], ["630", "IL", "Central Time (US & Canada)"], ["779", "IL", "Central Time (US & Canada)"], ["909", "CA", "Pacific Time (US & Canada)"],
  ["219", "IN", "Eastern Time (US & Canada)"], ["337", "LA", "Central Time (US & Canada)"], ["508", "MA", "Eastern Time (US & Canada)"], ["631", "NY", "Eastern Time (US & Canada)"], ["780", "AB", "Mountain Time (US & Canada)"], ["910", "NC", "Eastern Time (US & Canada)"],
  ["224", "IL", "Central Time (US & Canada)"], ["339", "MA", "Eastern Time (US & Canada)"], ["509", "WA", "Pacific Time (US & Canada)"], ["636", "MO", "Central Time (US & Canada)"], ["781", "MA", "Eastern Time (US & Canada)"], ["912", "GA", "Eastern Time (US & Canada)"],
  ["225", "LA", "Central Time (US & Canada)"], ["340", "VI", "Eastern Time (US & Canada)"], ["510", "CA", "Pacific Time (US & Canada)"], ["641", "IA", "Central Time (US & Canada)"], ["785", "KS", "Central Time (US & Canada)"], ["913", "KS", "Central Time (US & Canada)"],
  ["226", "ON", "Eastern Time (US & Canada)"], ["347", "NY", "Eastern Time (US & Canada)"], ["512", "TX", "Central Time (US & Canada)"], ["646", "NY", "Eastern Time (US & Canada)"], ["786", "FL", "Eastern Time (US & Canada)"], ["914", "NY", "Eastern Time (US & Canada)"],
  ["228", "MS", "Central Time (US & Canada)"], ["351", "MA", "Eastern Time (US & Canada)"], ["513", "OH", "Eastern Time (US & Canada)"], ["647", "ON", "Eastern Time (US & Canada)"], ["801", "UT", "Mountain Time (US & Canada)"], ["915", "TX", "Central Time (US & Canada)"], 
  ["229", "GA", "Eastern Time (US & Canada)"], ["352", "FL", "Eastern Time (US & Canada)"], ["514", "QC", "Eastern Time (US & Canada)"], ["650", "CA", "Pacific Time (US & Canada)"], ["802", "VT", "Eastern Time (US & Canada)"], ["916", "CA", "Pacific Time (US & Canada)"],
  ["231", "MI", "Eastern Time (US & Canada)"], ["360", "WA", "Pacific Time (US & Canada)"], ["515", "IA", "Central Time (US & Canada)"], ["651", "MN", "Central Time (US & Canada)"], ["803", "SC", "Eastern Time (US & Canada)"], ["917", "NY", "Eastern Time (US & Canada)"],
  ["234", "OH", "Eastern Time (US & Canada)"], ["361", "TX", "Central Time (US & Canada)"], ["516", "NY", "Eastern Time (US & Canada)"], ["657", "CA", "Pacific Time (US & Canada)"], ["804", "VA", "Eastern Time (US & Canada)"], ["918", "OK", "Central Time (US & Canada)"],
  ["239", "FL", "Eastern Time (US & Canada)"], ["386", "FL", "Eastern Time (US & Canada)"], ["517", "MI", "Eastern Time (US & Canada)"], ["660", "MO", "Central Time (US & Canada)"], ["805", "CA", "Pacific Time (US & Canada)"], ["919", "NC", "Eastern Time (US & Canada)"],
  ["240", "MD", "Eastern Time (US & Canada)"], ["401", "RI", "Eastern Time (US & Canada)"], ["518", "NY", "Eastern Time (US & Canada)"], ["661", "CA", "Pacific Time (US & Canada)"], ["806", "TX", "Central Time (US & Canada)"], ["920", "WI", "Central Time (US & Canada)"],
  ["248", "MI", "Eastern Time (US & Canada)"], ["402", "NE", "Central Time (US & Canada)"], ["519", "ON", "Eastern Time (US & Canada)"], ["662", "MS", "Central Time (US & Canada)"], ["807", "ON", "Eastern Time (US & Canada)"], ["925", "CA", "Pacific Time (US & Canada)"],
  ["250", "BC", "Pacific Time (US & Canada)"], ["403", "AB", "Mountain Time (US & Canada)"], ["520", "AZ", "Mountain Time (US & Canada)"], ["678", "GA", "Eastern Time (US & Canada)"], ["808", "HI", "Hawaii"], ["928", "AZ", "Mountain Time (US & Canada)"],
  ["251", "AL", "Central Time (US & Canada)"], ["404", "GA", "Eastern Time (US & Canada)"], ["530", "CA", "Pacific Time (US & Canada)"], ["682", "TX", "Central Time (US & Canada)"], ["810", "MI", "Eastern Time (US & Canada)"], ["931", "TN", "Central Time (US & Canada)"],
  ["252", "NC", "Eastern Time (US & Canada)"], ["405", "OK", "Central Time (US & Canada)"], ["540", "VA", "Eastern Time (US & Canada)"], ["701", "ND", "Central Time (US & Canada)"], ["812", "IN", "Eastern Time (US & Canada)"], ["936", "TX", "Central Time (US & Canada)"],
  ["253", "WA", "Pacific Time (US & Canada)"], ["406", "MT", "Mountain Time (US & Canada)"], ["541", "OR", "Pacific Time (US & Canada)"], ["702", "NV", "Pacific Time (US & Canada)"], ["813", "FL", "Eastern Time (US & Canada)"], ["937", "OH", "Eastern Time (US & Canada)"],
  ["254", "TX", "Central Time (US & Canada)"], ["407", "FL", "Eastern Time (US & Canada)"], ["551", "NJ", "Eastern Time (US & Canada)"], ["703", "VA", "Eastern Time (US & Canada)"], ["814", "PA", "Eastern Time (US & Canada)"], ["940", "TX", "Central Time (US & Canada)"],
  ["256", "AL", "Central Time (US & Canada)"], ["408", "CA", "Pacific Time (US & Canada)"], ["559", "CA", "Pacific Time (US & Canada)"], ["704", "NC", "Eastern Time (US & Canada)"], ["815", "IL", "Central Time (US & Canada)"], ["941", "FL", "Eastern Time (US & Canada)"],
  ["260", "IN", "Eastern Time (US & Canada)"], ["409", "TX", "Central Time (US & Canada)"], ["561", "FL", "Eastern Time (US & Canada)"], ["705", "ON", "Eastern Time (US & Canada)"], ["816", "MO", "Central Time (US & Canada)"], ["947", "MI", "Eastern Time (US & Canada)"],
  ["262", "WI", "Central Time (US & Canada)"], ["410", "MD", "Eastern Time (US & Canada)"], ["562", "CA", "Pacific Time (US & Canada)"], ["706", "GA", "Eastern Time (US & Canada)"], ["817", "TX", "Central Time (US & Canada)"], ["949", "CA", "Pacific Time (US & Canada)"],
  ["267", "PA", "Eastern Time (US & Canada)"], ["412", "PA", "Eastern Time (US & Canada)"], ["563", "IA", "Central Time (US & Canada)"], ["707", "CA", "Pacific Time (US & Canada)"], ["818", "CA", "Pacific Time (US & Canada)"], ["951", "CA", "Pacific Time (US & Canada)"],
  ["269", "MI", "Eastern Time (US & Canada)"], ["413", "MA", "Eastern Time (US & Canada)"], ["567", "OH", "Eastern Time (US & Canada)"], ["708", "IL", "Central Time (US & Canada)"], ["819", "QC", "Eastern Time (US & Canada)"], ["952", "MN", "Central Time (US & Canada)"],
  ["270", "KY", "Central Time (US & Canada)"], ["414", "WI", "Central Time (US & Canada)"], ["570", "PA", "Eastern Time (US & Canada)"], ["709", "NL", "Eastern Time (US & Canada)"], ["828", "NC", "Eastern Time (US & Canada)"], ["954", "FL", "Eastern Time (US & Canada)"],
  ["276", "VA", "Eastern Time (US & Canada)"], ["415", "CA", "Pacific Time (US & Canada)"], ["571", "VA", "Eastern Time (US & Canada)"], ["712", "IA", "Central Time (US & Canada)"], ["830", "TX", "Central Time (US & Canada)"], ["956", "TX", "Central Time (US & Canada)"],
  ["281", "TX", "Central Time (US & Canada)"], ["416", "ON", "Eastern Time (US & Canada)"], ["573", "MO", "Central Time (US & Canada)"], ["713", "TX", "Central Time (US & Canada)"], ["831", "CA", "Pacific Time (US & Canada)"], ["970", "CO", "Mountain Time (US & Canada)"],
  ["289", "ON", "Eastern Time (US & Canada)"], ["417", "MO", "Central Time (US & Canada)"], ["574", "IN", "Eastern Time (US & Canada)"], ["714", "CA", "Pacific Time (US & Canada)"], ["832", "TX", "Central Time (US & Canada)"], ["971", "OR", "Pacific Time (US & Canada)"],
  ["301", "MD", "Eastern Time (US & Canada)"], ["418", "QC", "Eastern Time (US & Canada)"], ["575", "NM", "Mountain Time (US & Canada)"], ["715", "WI", "Central Time (US & Canada)"], ["843", "SC", "Eastern Time (US & Canada)"], ["972", "TX", "Central Time (US & Canada)"],
  ["302", "DE", "Eastern Time (US & Canada)"], ["419", "OH", "Eastern Time (US & Canada)"], ["580", "OK", "Central Time (US & Canada)"], ["716", "NY", "Eastern Time (US & Canada)"], ["845", "NY", "Eastern Time (US & Canada)"], ["973", "NJ", "Eastern Time (US & Canada)"],
  ["303", "CO", "Mountain Time (US & Canada)"], ["423", "TN", "Eastern Time (US & Canada)"], ["585", "NY", "Eastern Time (US & Canada)"], ["717", "PA", "Eastern Time (US & Canada)"], ["847", "IL", "Central Time (US & Canada)"], ["978", "MA", "Eastern Time (US & Canada)"],
  ["304", "WV", "Eastern Time (US & Canada)"], ["424", "CA", "Pacific Time (US & Canada)"], ["586", "MI", "Eastern Time (US & Canada)"], ["718", "NY", "Eastern Time (US & Canada)"], ["848", "NJ", "Eastern Time (US & Canada)"], ["979", "TX", "Central Time (US & Canada)"],
  ["305", "FL", "Eastern Time (US & Canada)"], ["425", "WA", "Pacific Time (US & Canada)"], ["601", "MS", "Central Time (US & Canada)"], ["719", "CO", "Mountain Time (US & Canada)"], ["850", "FL", "Central Time (US & Canada)"], ["980", "NC", "Eastern Time (US & Canada)"],
  ["306", "SK", "Mountain Time (US & Canada)"], ["430", "TX", "Central Time (US & Canada)"], ["602", "AZ", "Mountain Time (US & Canada)"], ["720", "CO", "Mountain Time (US & Canada)"], ["856", "NJ", "Eastern Time (US & Canada)"], ["985", "LA", "Central Time (US & Canada)"],
  ["307", "WY", "Mountain Time (US & Canada)"], ["432", "TX", "Central Time (US & Canada)"], ["603", "NH", "Eastern Time (US & Canada)"], ["724", "PA", "Eastern Time (US & Canada)"], ["857", "MA", "Eastern Time (US & Canada)"], ["989", "MI", "Eastern Time (US & Canada)"],
  ["308", "NE", "Central Time (US & Canada)"], ["434", "VA", "Eastern Time (US & Canada)"], ["604", "BC", "Pacific Time (US & Canada)"], ["727", "FL", "Eastern Time (US & Canada)"], ["858", "CA", "Pacific Time (US & Canada)"],                     
  ["309", "IL", "Central Time (US & Canada)"], ["435", "UT", "Mountain Time (US & Canada)"], ["605", "SD", "Central Time (US & Canada)"], ["731", "TN", "Central Time (US & Canada)"], ["859", "KY", "Eastern Time (US & Canada)"]
].each do |ac|
  area_codes[ac[0]] = ac
end

get '/' do
  ret = %{
    <html><head><title>Area Code to Time Zone</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js"></script>
    </head><body>
    Zip Code: <input type="input" name="area_code" id="area_code" size="3" /> 
    <input type="submit" value="Search" onclick="window.location='/'+$('#area_code').val(); return false;"/>
    </body></html>
  }
  ret
end

get '/:area_code' do
  content_type 'application/xml', :charset => 'iso-8859-1'
  to_xml(area_codes[params[:area_code]])
end