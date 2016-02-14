CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider => 'AWS',
        :aws_access_key_id => "AKIAJOU3CYBT7AOOVVAA",
        :aws_secret_access_key => "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",
        :region => 'ap-northeast-2'
    }
    config.fog_directory = "eurekamath"
end    