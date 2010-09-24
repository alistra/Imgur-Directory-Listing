begin
  Image.read_dir
rescue ActiveRecord::StatementInvalid => er
  puts "Not reading directories during migrations"
end

