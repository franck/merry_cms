I18n.backend = Globalize::Backend::Static.new
I18n.load_path << "#{RAILS_ROOT}/config/locales"
I18n.load_path.locales = ["fr", "de"]
I18n.default_locale = "fr"
I18n.fallbacks[:fr] = ["fr", "de", :root]
I18n.fallbacks[:de] = ["de", "fr", :root]