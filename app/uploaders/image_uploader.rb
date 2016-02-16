class ImageUploader < CarrierWave::Uploader::Base
   
    include CarrierWave::MiniMagick
    
    storage :fog
    
    def store_dir
        if Rails.env.production?
            "uploads/#{model.unit_concept.id}/#{model.class.to_s.underscore}/#{model.id}"
        else
            "tests/#{model.unit_concept.id}/#{model.class.to_s.underscore}/#{model.id}"            
        end        
    end
    
    version :large do
        process resize_to_limit: [800, 800]
    end
    
    version :medium, :from_version => :large do
        process resize_to_limit: [500, 500]
    end
    
    version :thumb, :from_version => :medium do
        process resize_to_fit: [100,100]
    end
    
end    