# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171022144401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "activities", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "trackable_id"
    t.string   "trackable_type", limit: 255
    t.uuid     "owner_id"
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters"
    t.uuid     "recipient_id"
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "adopt_a_pet_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "organization_id"
    t.boolean  "active",          default: false
    t.text     "user_name"
    t.text     "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["organization_id"], name: "index_adopt_a_pet_accounts_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_adopt_a_pet_accounts_on_user_id", using: :btree
  end

  create_table "adopt_animals", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.uuid     "adoption_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["adoption_contact_id"], name: "index_adopt_animals_on_adoption_contact_id", using: :btree
    t.index ["animal_id"], name: "index_adopt_animals_on_animal_id", using: :btree
  end

  create_table "adoption_contacts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "address",         limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.datetime "adopted_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_adoption_contacts_on_organization_id", using: :btree
  end

  create_table "animal_colors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "color",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_animal_colors_on_organization_id", using: :btree
  end

  create_table "animal_sexes", force: :cascade do |t|
    t.string   "sex",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_weights", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.datetime "date_of_weight"
    t.index ["animal_id"], name: "index_animal_weights_on_animal_id", using: :btree
    t.index ["organization_id"], name: "index_animal_weights_on_organization_id", using: :btree
  end

  create_table "animals", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "previous_name",             limit: 255
    t.uuid     "species_id"
    t.text     "special_needs"
    t.text     "diet"
    t.datetime "date_of_intake"
    t.datetime "date_of_well_check"
    t.uuid     "shelter_id"
    t.datetime "deceased"
    t.text     "deceased_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.datetime "adopted_date"
    t.uuid     "animal_color_id"
    t.string   "image",                     limit: 255
    t.string   "image_file_name",           limit: 255
    t.string   "image_content_type",        limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "public",                                default: 0
    t.datetime "birthday"
    t.integer  "animal_sex_id"
    t.integer  "spay_neuter_id"
    t.integer  "biter_id"
    t.uuid     "status_id"
    t.string   "second_image",              limit: 255
    t.string   "second_image_file_name",    limit: 255
    t.string   "second_image_content_type", limit: 255
    t.integer  "second_image_file_size"
    t.datetime "second_image_updated_at"
    t.string   "third_image",               limit: 255
    t.string   "third_image_file_name",     limit: 255
    t.string   "third_image_content_type",  limit: 255
    t.integer  "third_image_file_size"
    t.datetime "third_image_updated_at"
    t.string   "fourth_image",              limit: 255
    t.string   "fourth_image_file_name",    limit: 255
    t.string   "fourth_image_content_type", limit: 255
    t.integer  "fourth_image_file_size"
    t.datetime "fourth_image_updated_at"
    t.text     "video_embed"
    t.string   "microchip",                 limit: 255
    t.integer  "impressions_count",                     default: 0
    t.boolean  "archived",                              default: false
    t.datetime "fostered_date"
    t.index ["animal_color_id"], name: "index_animals_on_animal_color_id", using: :btree
    t.index ["animal_sex_id"], name: "index_animals_on_animal_sex_id", using: :btree
    t.index ["archived"], name: "index_animals_on_archived", using: :btree
    t.index ["biter_id"], name: "index_animals_on_biter_id", using: :btree
    t.index ["organization_id"], name: "index_animals_on_organization_id", using: :btree
    t.index ["public"], name: "index_animals_on_public", using: :btree
    t.index ["shelter_id"], name: "index_animals_on_shelter_id", using: :btree
    t.index ["spay_neuter_id"], name: "index_animals_on_spay_neuter_id", using: :btree
    t.index ["species_id"], name: "index_animals_on_species_id", using: :btree
    t.index ["status_id"], name: "index_animals_on_status_id", using: :btree
  end

  create_table "biters", force: :cascade do |t|
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_notes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "note"
    t.string   "user_id"
    t.string   "organization_id"
    t.string   "noteable_id"
    t.string   "noteable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["noteable_type", "noteable_id"], name: "index_contact_notes_on_noteable_type_and_noteable_id", using: :btree
  end

  create_table "documents", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.string   "document",              limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.uuid     "documentable_id"
    t.string   "documentable_type",     limit: 255
    t.uuid     "organization_id"
    t.index ["animal_id"], name: "index_documents_on_animal_id", using: :btree
    t.index ["documentable_id", "documentable_type"], name: "index_documents_on_documentable_id_and_documentable_type", using: :btree
    t.index ["organization_id"], name: "index_documents_on_organization_id", using: :btree
  end

  create_table "email_blacklists", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "domain", limit: 255
  end

  create_table "events", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.string   "event_type",         limit: 255
    t.text     "event_message"
    t.uuid     "related_model_id"
    t.string   "related_model_name", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.uuid     "organization_id"
    t.string   "record_uuid",        limit: 255
    t.index ["animal_id"], name: "index_animal_events_on_animal_id", using: :btree
    t.index ["event_type"], name: "index_animal_events_on_event_type", using: :btree
    t.index ["organization_id"], name: "index_animal_events_on_organization_id", using: :btree
    t.index ["record_uuid"], name: "index_events_on_record_uuid", using: :btree
    t.index ["related_model_id"], name: "index_animal_events_on_related_model_id", using: :btree
  end

  create_table "facebook_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.boolean  "active",              default: false
    t.text     "stream_url"
    t.text     "access_token"
    t.text     "oauth_authorize_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_facebook_accounts_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_facebook_accounts_on_user_id", using: :btree
  end

  create_table "foster_animals", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.uuid     "foster_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foster_contacts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "address",         limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.uuid     "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.uuid     "impressionable_id"
    t.uuid     "user_id"
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
    t.index ["user_id"], name: "index_impressions_on_user_id", using: :btree
  end

  create_table "notes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.uuid     "user_id"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_notes_on_animal_id", using: :btree
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "notifications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_type", limit: 255
  end

  create_table "organizations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number",                     limit: 255
    t.string   "address",                          limit: 255
    t.string   "city",                             limit: 255
    t.string   "state",                            limit: 255
    t.string   "zip_code",                         limit: 255
    t.string   "email",                            limit: 255
    t.string   "website",                          limit: 255
    t.string   "adoption_form_file_name",          limit: 255
    t.string   "adoption_form_content_type",       limit: 255
    t.integer  "adoption_form_file_size"
    t.datetime "adoption_form_updated_at"
    t.string   "volunteer_form_file_name",         limit: 255
    t.string   "volunteer_form_content_type",      limit: 255
    t.integer  "volunteer_form_file_size"
    t.datetime "volunteer_form_updated_at"
    t.string   "relinquishment_form_file_name",    limit: 255
    t.string   "relinquishment_form_content_type", limit: 255
    t.integer  "relinquishment_form_file_size"
    t.datetime "relinquishment_form_updated_at"
    t.string   "foster_form_file_name",            limit: 255
    t.string   "foster_form_content_type",         limit: 255
    t.integer  "foster_form_file_size"
    t.datetime "foster_form_updated_at"
  end

  create_table "organizations_users", id: false, force: :cascade do |t|
    t.integer "organization_id"
    t.integer "user_id"
    t.index ["organization_id"], name: "index_organizations_users_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_organizations_users_on_user_id", using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.uuid     "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["role_id"], name: "index_permissions_on_role_id", using: :btree
    t.index ["user_id"], name: "index_permissions_on_user_id", using: :btree
  end

  create_table "petfinder_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.boolean  "active",       default: false
    t.text     "ftp_user"
    t.text     "ftp_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",              limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["animal_id"], name: "index_photos_on_animal_id", using: :btree
  end

  create_table "posts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "author",     limit: 255
    t.string   "title",      limit: 255
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
    t.index ["slug"], name: "index_posts_on_slug", using: :btree
  end

  create_table "relinquish_animals", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.uuid     "relinquishment_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["animal_id"], name: "index_relinquish_animals_on_animal_id", using: :btree
    t.index ["relinquishment_contact_id"], name: "index_relinquish_animals_on_relinquishment_contact_id", using: :btree
  end

  create_table "relinquishment_contacts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "address",         limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_relinquishment_contacts_on_organization_id", using: :btree
  end

  create_table "reports", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "report",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_reports_on_organization_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "shelters", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "contact_first",   limit: 255
    t.string   "contact_last",    limit: 255
    t.string   "address",         limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.string   "website",         limit: 255
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_shelters_on_organization_id", using: :btree
  end

  create_table "shots", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "animal_id"
    t.string   "name",              limit: 255
    t.datetime "last_administered"
    t.datetime "expires"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.uuid     "organization_id"
    t.index ["animal_id"], name: "index_shots_on_animal_id", using: :btree
    t.index ["expires"], name: "index_shots_on_expires", using: :btree
    t.index ["organization_id"], name: "index_shots_on_organization_id", using: :btree
  end

  create_table "spay_neuters", force: :cascade do |t|
    t.string   "spay",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_species_on_organization_id", using: :btree
  end

  create_table "statuses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "status",          limit: 255
    t.uuid     "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["organization_id"], name: "index_statuses_on_organization_id", using: :btree
  end

  create_table "twitter_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.boolean  "active",                           default: false
    t.text     "stream_url"
    t.string   "oauth_token",          limit: 255
    t.string   "oauth_token_secret",   limit: 255
    t.string   "oauth_token_verifier", limit: 255
    t.text     "oauth_authorize_url"
    t.uuid     "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["organization_id"], name: "index_twitter_accounts_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_twitter_accounts_on_user_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email",                  limit: 255,             null: false
    t.string   "encrypted_password",     limit: 128,             null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.uuid     "organization_id"
    t.string   "organization_name",      limit: 255
    t.integer  "owner",                              default: 0
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "authentication_token",   limit: 255
    t.string   "unconfirmed_email"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["organization_id"], name: "index_users_on_organization_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "vet_contacts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "clinic_name",     limit: 255
    t.string   "address",         limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.string   "website",         limit: 255
    t.string   "hours",           limit: 255
    t.string   "emergency",       limit: 255
    t.uuid     "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["organization_id"], name: "index_vet_contacts_on_organization_id", using: :btree
  end

  create_table "volunteer_contacts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "address",          limit: 255
    t.string   "phone",            limit: 255
    t.string   "email",            limit: 255
    t.datetime "application_date"
    t.uuid     "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["organization_id"], name: "index_volunteer_contacts_on_organization_id", using: :btree
  end

  create_table "wordpress_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.boolean  "active",          default: false
    t.text     "site_url"
    t.text     "blog_user"
    t.text     "blog_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "organization_id"
    t.index ["organization_id"], name: "index_wordpress_accounts_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_wordpress_accounts_on_user_id", using: :btree
  end

end
