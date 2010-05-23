namespace :cata_monitor do
  desc "Process Queries"
  task :process_queries => :environment do
    CataMonitor::QueriesProcessor.process_all
  end
end