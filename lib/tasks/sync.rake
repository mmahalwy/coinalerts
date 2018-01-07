namespace :sync do
  desc 'Perform sync'
  task perform: :environment do
    Sync.new(send_notifications: true).perform
  end

end
