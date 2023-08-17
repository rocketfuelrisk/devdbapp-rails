class AuditEvent < ApplicationRecord
  belongs_to :organization

  store_accessor :audit_data, :ip
end
