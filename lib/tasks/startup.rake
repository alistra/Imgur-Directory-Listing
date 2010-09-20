namespace :startup do
  task :run => :environment do
    Image.read_dir
    puts "Images directory read"
  end
end
