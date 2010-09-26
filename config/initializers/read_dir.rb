ENV['DISABLE_INITIALIZER_FROM_RAKE'] || Image.read_dir

=begin require 'rb-inotify'
  
  notifier = INotify::Notifier.new
  notifier.watch("/srv/www/", :moved_to, :create, :delete, :moved_from) do
    Image.read_dir
  end
  notifier.process
=end
