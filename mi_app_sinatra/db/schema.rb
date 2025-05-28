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

ActiveRecord::Schema[8.0].define(version: 2025_05_27_210408) do
  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "email"
    t.decimal "balance", default: "0.0"
    t.string "cvu"
    t.string "alias"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alias"], name: "index_accounts_on_alias", unique: true
    t.index ["cvu"], name: "index_accounts_on_cvu", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "num_transaction"
    t.datetime "date"
    t.string "description"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "source_account_id"
    t.integer "target_account_id"
    t.index ["num_transaction"], name: "index_transactions_on_num_transaction", unique: true
    t.index ["source_account_id"], name: "index_transactions_on_source_account_id"
    t.index ["target_account_id"], name: "index_transactions_on_target_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "dni"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dni"], name: "index_users_on_dni", unique: true
  end

  add_foreign_key "accounts", "users"
end
