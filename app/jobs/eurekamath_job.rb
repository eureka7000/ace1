class EurekamathJob < ActiveJob::Base
    
    queue_as :default

    def perform(*args)
        Rails.logger.debug "********** What is this ??? " + args.inspect
    end
    
end
