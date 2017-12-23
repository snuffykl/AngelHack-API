require 'rake/testtask'

task :default => [:build_image]

task :build_image do
    sh "sudo docker build -t angelhack-api -f ./Dockerfile ."
end

task :test do
  test = Rake::TestTask.new 
  test.libs << "test"
  test.test_files = FileList['tests/**/*_test.rb']
  test.verbose = true
end
