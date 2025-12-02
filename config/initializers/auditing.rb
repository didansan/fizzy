Rails.application.configure do |app|
  app.config.before_initialize do
    config.audits1984.base_controller_class = "::AdminController"
    config.audits1984.auditor_class = "::Identity"
    config.audits1984.auditor_name_attribute = :email_address

    config.console1984.protected_environments = %i[ production beta staging ]
    config.console1984.ask_for_username_if_empty = true

    if config.console1984.protected_environments.include?(Rails.env.to_sym)
      config.active_record.encryption.primary_key = ENV.fetch("ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY")
      config.active_record.encryption.deterministic_key = ENV.fetch("ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY")
      config.active_record.encryption.key_derivation_salt = ENV.fetch("ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT")
    end
  end
end
