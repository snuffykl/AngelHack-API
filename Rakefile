require 'rake/testtask'

task :default => [:build_image]

task :build_image do
    sh "sudo docker build -t angelhack-api -f ./Dockerfile ."
end