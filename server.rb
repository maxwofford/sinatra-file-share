require 'sinatra'
require "sinatra/activerecord"
require './environments'
require 'haml'

# Models

class Document < ActiveRecord::Base

end

# Views

get '/' do
	haml :index 
end

# Downloads
get '/download/:filename' do |filename|
	send_file "./files/#{filename}", :filename => filename, :type => 'Application/octet-stream'
end

# Uploads
get '/upload' do
	haml :upload
end

get '/upload/list' do
	@base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
	@list = Dir.glob("./uploads/*.*").map{|f| f.split('/').last}
	haml :list
end

post '/upload' do
	filename = params['myfile'][:filename]
	
	# Check uniqueness of file name
	if Dir.glob("./uploads/*.*").map{|f| f.split('/').last}.include?(filename)
		filename = filename + "(#{rand(1000)})"
	end

	# Download the file
	File.open('uploads/' + filename, "w") do |f|
		f.write(params['myfile'][:tempfile].read)
	end
	return "File successfully uploaded"
end
