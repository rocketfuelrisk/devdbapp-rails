class Initial < ActiveRecord::Migration[7.0]
  def change
    enable_extension "plpgsql"

    create_enum "gender", ["m", "f", "u"]

    create_table "audit_events", force: :cascade do |t|
      t.bigint "organization_id", null: false
      t.text "action", null: false
      t.jsonb "audit_data", default: {}, null: false
      t.datetime "created_at"
      t.index ["organization_id"], name: "index_audit_events_on_organization_id"
    end

    create_table "campaigns", force: :cascade do |t|
      t.bigint "organization_id", null: false
      t.text "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["organization_id", "name"], name: "index_campaigns_on_organization_id_and_name", unique: true
      t.index ["organization_id"], name: "index_campaigns_on_organization_id"
    end

    create_table "eligibility_records", force: :cascade do |t|
      t.bigint "organization_id", null: false
      t.bigint "patient_id"
      t.text "first_name"
      t.text "last_name"
      t.integer "gender"
      t.date "date_of_birth"
      t.jsonb "extras"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["organization_id"], name: "index_eligibility_records_on_organization_id"
    end

    create_table "event_sessions", force: :cascade do |t|
      t.bigint "event_id", null: false
      t.bigint "location_id", null: false
      t.datetime "starts_at", null: false
      t.datetime "ends_at", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_id"], name: "index_event_sessions_on_event_id"
      t.index ["location_id"], name: "index_event_sessions_on_location_id"
    end

    create_table "events", force: :cascade do |t|
      t.bigint "campaign_id", null: false
      t.text "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["campaign_id", "name"], name: "index_events_on_campaign_id_and_name", unique: true
      t.index ["campaign_id"], name: "index_events_on_campaign_id"
    end

    create_table "home_test_kits", force: :cascade do |t|
      t.bigint "event_id", null: false
      t.bigint "patient_id", null: false
      t.text "medical_record_number", null: false
      t.text "status", default: "pending", null: false
      t.text "tracking_number"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_id"], name: "index_home_test_kits_on_event_id"
      t.index ["patient_id"], name: "index_home_test_kits_on_patient_id"
      t.check_constraint "status = ANY (ARRAY['pending'::text, 'shipped'::text, 'received'::text, 'processing'::text, 'processed'::text, 'error'::text])", name: "home_test_kits_status_check"
    end

    create_table "locations", force: :cascade do |t|
      t.bigint "organization_id", null: false
      t.text "name", null: false
      t.decimal "latitude", precision: 9, scale: 6
      t.decimal "longitude", precision: 9, scale: 6
      t.point "coordinates"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["organization_id", "name"], name: "index_locations_on_organization_id_and_name", unique: true
      t.index ["organization_id"], name: "index_locations_on_organization_id"
    end

    create_table "measurements", force: :cascade do |t|
      t.text "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name"], name: "index_measurements_on_name", unique: true
    end

    create_table "offsite_appointments", force: :cascade do |t|
      t.bigint "event_id", null: false
      t.bigint "patient_id", null: false
      t.text "medical_record_number", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_id"], name: "index_offsite_appointments_on_event_id"
    end

    create_table "onsite_appointments", force: :cascade do |t|
      t.bigint "timeslot_id", null: false
      t.bigint "patient_id", null: false
      t.text "medical_record_number", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["patient_id"], name: "index_onsite_appointments_on_patient_id"
      t.index ["timeslot_id"], name: "index_onsite_appointments_on_timeslot_id"
    end

    create_table "organizations", force: :cascade do |t|
      t.text "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name"], name: "index_organizations_on_name", unique: true
    end

    create_table "patients", force: :cascade do |t|
      t.bigint "organization_id", null: false
      t.text "first_name", null: false
      t.text "last_name", null: false
      t.enum "gender", enum_type: "gender"
      t.date "date_of_birth"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["organization_id"], name: "index_patients_on_organization_id"
    end

    create_table "reports", force: :cascade do |t|
      t.bigint "organization_id", null: false
      t.text "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["organization_id"], name: "index_reports_on_organization_id"
    end

    create_table "result_sets", force: :cascade do |t|
      t.bigint "patient_id"
      t.text "medical_record_number", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["patient_id"], name: "index_result_sets_on_patient_id"
    end

    create_table "results", force: :cascade do |t|
      t.bigint "result_set_id", null: false
      t.bigint "measurement_id", null: false
      t.text "value", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["measurement_id"], name: "index_results_on_measurement_id"
      t.index ["result_set_id"], name: "index_results_on_result_set_id"
    end

    create_table "timeslots", force: :cascade do |t|
      t.bigint "event_session_id", null: false
      t.datetime "starts_at", null: false
      t.integer "capacity", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_session_id"], name: "index_timeslots_on_event_session_id"
    end

    add_foreign_key "audit_events", "organizations", on_update: :cascade, on_delete: :cascade
    add_foreign_key "campaigns", "organizations", on_update: :cascade, on_delete: :cascade
    add_foreign_key "eligibility_records", "organizations", on_update: :cascade, on_delete: :cascade
    add_foreign_key "eligibility_records", "patients", on_update: :cascade, on_delete: :cascade
    add_foreign_key "event_sessions", "events", on_update: :cascade, on_delete: :cascade
    add_foreign_key "event_sessions", "locations", on_update: :cascade, on_delete: :cascade
    add_foreign_key "events", "campaigns", on_update: :cascade, on_delete: :cascade
    add_foreign_key "home_test_kits", "events", on_update: :cascade, on_delete: :cascade
    add_foreign_key "home_test_kits", "patients", on_update: :cascade, on_delete: :cascade
    add_foreign_key "locations", "organizations", on_update: :cascade, on_delete: :cascade
    add_foreign_key "offsite_appointments", "events", on_update: :cascade, on_delete: :cascade
    add_foreign_key "offsite_appointments", "patients", on_update: :cascade, on_delete: :cascade
    add_foreign_key "onsite_appointments", "patients", on_update: :cascade, on_delete: :cascade
    add_foreign_key "onsite_appointments", "timeslots", on_update: :cascade, on_delete: :cascade
    add_foreign_key "patients", "organizations", on_update: :cascade, on_delete: :cascade
    add_foreign_key "reports", "organizations", on_update: :cascade, on_delete: :cascade
    add_foreign_key "result_sets", "patients", on_update: :cascade, on_delete: :cascade
    add_foreign_key "results", "measurements", on_update: :cascade, on_delete: :cascade
    add_foreign_key "results", "result_sets", on_update: :cascade, on_delete: :cascade
    add_foreign_key "timeslots", "event_sessions", on_update: :cascade, on_delete: :cascade
  end
end
