class AdminController < ApplicationController
  disallow_account_scope
  before_action :ensure_staff

  private
    # For Audits1984 to determine the current auditor.
    def find_current_auditor
      Current.identity
    end
end
