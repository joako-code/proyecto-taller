# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_29_135907) do
  create_table "accounts", primary_key: "cvu", id: :string, force: :cascade do |t|
    t.string "dni", null: false
    t.string "email", null: false
    t.integer "balance", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dni"], name: "index_accounts_on_dni", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "transactions", primary_key: "transaction_id", force: :cascade do |t|
    t.integer "amount", null: false
    t.date "date", null: false
    t.string "description", limit: 146
    t.string "transaction_type", null: false
    t.string "account_cvu", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", primary_key: "transaction_id", force: :cascade do |t|
    t.string "from_cvu", null: false
    t.string "to_cvu", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "dni", id: :string, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "users", column: "dni", primary_key: "dni"
  add_foreign_key "transactions", "accounts", column: "account_cvu", primary_key: "cvu"
  add_foreign_key "transfers", "accounts", column: "from_cvu", primary_key: "cvu"
  add_foreign_key "transfers", "accounts", column: "to_cvu", primary_key: "cvu"
  add_foreign_key "transfers", "transactions", primary_key: "transaction_id"
end
