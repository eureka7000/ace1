I18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml")]
I18n.default_locale = :ko
I18n.reload!