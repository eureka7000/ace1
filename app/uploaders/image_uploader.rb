class ImageUploader < CarrierWave::Uploader::Base
   
    include CarrierWave::MiniMagick
    
    storage :fog
    
    def store_dir
        if Rails.env.production?
            "uploads/#{model.class.to_s.underscore}/#{model.id}"
        else
            "tests/#{model.class.to_s.underscore}/#{model.id}"            
        end        
    end
    
    version :large do
        process resize_to_limit: [500, 500]
    end
    
    version :medium, :from_version => :large do
        process resize_to_limit: [300, 300]
    end
    
    version :thumb, :from_version => :medium do
        process resize_to_fit: [100,100]
    end
    
end    