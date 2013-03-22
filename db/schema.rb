# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130322091539) do

  create_table "arrondissements", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "refinery_crpv_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "departements", :force => true do |t|
    t.string   "name"
    t.string   "cp"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "refinery_crpv_id"
  end

  add_index "departements", ["cp"], :name => "index_departements_on_cp"
  add_index "departements", ["name"], :name => "index_departements_on_name"

  create_table "dossiers", :force => true do |t|
    t.string   "code_bnpv"
    t.date     "date_recueil"
    t.boolean  "doublon"
    t.integer  "j_evenement"
    t.integer  "m_evenement"
    t.integer  "a_evenement"
    t.text     "comm_evenement"
    t.string   "gravite"
    t.string   "evolution"
    t.text     "commentaire"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "hydra_set_id"
    t.integer  "evenement_id"
    t.integer  "refinery_crpv_id"
  end

  add_index "dossiers", ["hydra_set_id"], :name => "refinery_enquetes_hydra_set_id_index"
  add_index "dossiers", ["refinery_crpv_id"], :name => "index_refinery_enquetes_on_refinery_crpv_id"

  create_table "enquete_fields", :force => true do |t|
    t.string   "name"
    t.string   "libelle"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "enquete_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "enquete_fields", ["enquete_id"], :name => "index_enquete_fields_on_enquete_id"

  create_table "enquetes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "evenement_choices", :force => true do |t|
    t.integer  "enquete_id"
    t.integer  "evenement_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "evenement_choices", ["enquete_id"], :name => "index_evenement_choices_on_type_enquete_id"
  add_index "evenement_choices", ["evenement_id"], :name => "index_evenement_choices_on_evenement_id"

  create_table "evenements", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "evenements", ["name"], :name => "index_evenements_on_name"

  create_table "hydra_attribute_sets", :id => false, :force => true do |t|
    t.integer "hydra_attribute_id", :null => false
    t.integer "hydra_set_id",       :null => false
  end

  add_index "hydra_attribute_sets", ["hydra_attribute_id", "hydra_set_id"], :name => "hydra_attribute_sets_index", :unique => true

  create_table "hydra_attributes", :force => true do |t|
    t.string   "entity_type",   :limit => 32,                    :null => false
    t.string   "name",          :limit => 32,                    :null => false
    t.string   "backend_type",  :limit => 16,                    :null => false
    t.string   "default_value"
    t.boolean  "white_list",                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "hydra_attributes", ["entity_type", "name"], :name => "hydra_attributes_index", :unique => true

  create_table "hydra_boolean_refinery_enquetes", :force => true do |t|
    t.integer  "entity_id",          :null => false
    t.integer  "hydra_attribute_id", :null => false
    t.boolean  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydra_boolean_refinery_enquetes", ["entity_id", "hydra_attribute_id"], :name => "hydra_boolean_refinery_enquetes_index", :unique => true

  create_table "hydra_datetime_refinery_enquetes", :force => true do |t|
    t.integer  "entity_id",          :null => false
    t.integer  "hydra_attribute_id", :null => false
    t.datetime "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydra_datetime_refinery_enquetes", ["entity_id", "hydra_attribute_id"], :name => "hydra_datetime_refinery_enquetes_index", :unique => true

  create_table "hydra_float_refinery_enquetes", :force => true do |t|
    t.integer  "entity_id",          :null => false
    t.integer  "hydra_attribute_id", :null => false
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydra_float_refinery_enquetes", ["entity_id", "hydra_attribute_id"], :name => "hydra_float_refinery_enquetes_index", :unique => true

  create_table "hydra_integer_refinery_enquetes", :force => true do |t|
    t.integer  "entity_id",          :null => false
    t.integer  "hydra_attribute_id", :null => false
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydra_integer_refinery_enquetes", ["entity_id", "hydra_attribute_id"], :name => "hydra_integer_refinery_enquetes_index", :unique => true

  create_table "hydra_sets", :force => true do |t|
    t.string   "entity_type", :limit => 32, :null => false
    t.string   "name",        :limit => 32, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "hydra_sets", ["entity_type", "name"], :name => "hydra_sets_index", :unique => true

  create_table "hydra_string_refinery_enquetes", :force => true do |t|
    t.integer  "entity_id",          :null => false
    t.integer  "hydra_attribute_id", :null => false
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydra_string_refinery_enquetes", ["entity_id", "hydra_attribute_id"], :name => "hydra_string_refinery_enquetes_index", :unique => true

  create_table "hydra_text_refinery_enquetes", :force => true do |t|
    t.integer  "entity_id",          :null => false
    t.integer  "hydra_attribute_id", :null => false
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydra_text_refinery_enquetes", ["entity_id", "hydra_attribute_id"], :name => "hydra_text_refinery_enquetes_index", :unique => true

  create_table "medicament_choices", :force => true do |t|
    t.integer  "medicament_id"
    t.integer  "enquete_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "medicament_choices", ["enquete_id"], :name => "index_medicament_choices_on_enquete_id"
  add_index "medicament_choices", ["medicament_id"], :name => "index_medicament_choices_on_medicament_id"

  create_table "medicaments", :force => true do |t|
    t.string   "name"
    t.string   "classe"
    t.string   "forme"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "patients", :force => true do |t|
    t.integer  "age"
    t.integer  "poids"
    t.integer  "taille"
    t.integer  "imc"
    t.integer  "dossier_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "patients", ["dossier_id"], :name => "index_patients_on_refinery_enquete_id"

  create_table "refinery_crpvs", :force => true do |t|
    t.string   "name"
    t.text     "adresse"
    t.string   "city"
    t.string   "cp"
    t.string   "responsable"
    t.string   "tel"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.string   "bulletin"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "refinery_crpvs", ["slug"], :name => "index_refinery_crpvs_on_slug"

  create_table "refinery_documents", :force => true do |t|
    t.string   "titre"
    t.date     "publication"
    t.integer  "document_category_id"
    t.integer  "fichier_id"
    t.integer  "position"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "refinery_documents_categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_inquiries_inquiries", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.boolean  "spam",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "refinery_inquiries_inquiries", ["id"], :name => "index_refinery_inquiries_inquiries_on_id"

  create_table "refinery_membership_email_part_translations", :force => true do |t|
    t.integer  "refinery_membership_email_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "refinery_membership_email_part_translations", ["locale"], :name => "index_refinery_membership_email_part_translations_on_locale"
  add_index "refinery_membership_email_part_translations", ["refinery_membership_email_part_id"], :name => "index_a67a470abc863aaf2d59f6b294eb9bb4414afa68"

  create_table "refinery_membership_email_parts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "refinery_membership_email_parts", ["title"], :name => "index_refinery_membership_email_parts_on_title", :unique => true

  create_table "refinery_membership_email_translations", :force => true do |t|
    t.integer  "refinery_membership_email_id"
    t.string   "locale"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "refinery_membership_email_translations", ["locale"], :name => "index_refinery_membership_email_translations_on_locale"
  add_index "refinery_membership_email_translations", ["refinery_membership_email_id"], :name => "index_2605064b986486e26049fef85d6ee6d5c6b78479"

  create_table "refinery_membership_emails", :force => true do |t|
    t.string   "title"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "refinery_membership_emails", ["title"], :name => "index_refinery_membership_emails_on_title", :unique => true

  create_table "refinery_news_categories", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_news_item_translations", :force => true do |t|
    t.integer  "refinery_news_item_id"
    t.string   "locale"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "source"
  end

  add_index "refinery_news_item_translations", ["locale"], :name => "index_refinery_news_item_translations_on_locale"
  add_index "refinery_news_item_translations", ["refinery_news_item_id"], :name => "index_2fe5614a8b4e9a5c34c0f93f230e423e36d53bda"

  create_table "refinery_news_items", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "publish_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "image_id"
    t.datetime "expiration_date"
    t.string   "source"
    t.string   "slug"
    t.integer  "news_category_id"
  end

  add_index "refinery_news_items", ["id"], :name => "index_refinery_news_items_on_id"
  add_index "refinery_news_items", ["news_category_id"], :name => "index_refinery_news_items_on_news_category_id"

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_f9716c4215584edbca2557e32706a5ae084a15ef"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_d079468f88bff1c6ea81573a0d019ba8bf5c2902"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_pages_roles", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "role_id"
  end

  create_table "refinery_projets_projets", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "titre"
    t.integer  "refinery_crpv_id"
    t.string   "but"
    t.string   "responsable"
    t.string   "exploitant"
    t.date     "date_requete"
    t.text     "effet"
    t.text     "medicament"
    t.text     "contexte"
    t.string   "design"
    t.text     "objectif"
    t.text     "objectif_sec"
    t.text     "champs"
    t.date     "debut_inclusion"
    t.date     "fin_inclusion"
    t.string   "type_inclusion"
    t.text     "criteres_inclusion"
    t.text     "criteres_non_inclusion"
    t.text     "retombees"
    t.string   "slug"
    t.string   "workflow_state"
  end

  add_index "refinery_projets_projets", ["id"], :name => "index_refinery_projets_projets_on_id"
  add_index "refinery_projets_projets", ["refinery_crpv_id"], :name => "index_refinery_projets_projets_on_refinery_crpv_id"
  add_index "refinery_projets_projets", ["slug"], :name => "index_refinery_projets_projets_on_slug"
  add_index "refinery_projets_projets", ["titre"], :name => "index_refinery_projets_projets_on_titre"
  add_index "refinery_projets_projets", ["workflow_state"], :name => "index_refinery_projets_projets_on_workflow_state"

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable",     :default => true
    t.string   "scoping"
    t.boolean  "restricted",      :default => false
    t.string   "form_value_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",                                             :null => false
    t.string   "email",                                                :null => false
    t.string   "encrypted_password",                                   :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.string   "organization"
    t.string   "street_address"
    t.string   "city"
    t.string   "postal_code"
    t.datetime "member_until"
    t.string   "membership_level",       :default => "Refinery::User"
    t.boolean  "enabled",                :default => false
    t.boolean  "seen",                   :default => false
    t.string   "rejected",               :default => "UNDECIDED"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "province"
    t.integer  "refinery_crpv_id"
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "traitements", :force => true do |t|
    t.integer  "dossier_id"
    t.integer  "medicament_id"
    t.integer  "j_debut"
    t.integer  "m_debut"
    t.integer  "a_debut"
    t.integer  "j_fin"
    t.integer  "m_fin"
    t.integer  "a_fin"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "traitements", ["dossier_id"], :name => "index_traitements_on_dossier_id"
  add_index "traitements", ["medicament_id"], :name => "index_traitements_on_medicament_id"

end
