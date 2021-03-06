# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120727064913) do

  create_table "codes", :force => true do |t|
    t.string   "crop_name"
    t.float    "lat"
    t.float    "lon"
    t.integer  "average_predicted_yield"
    t.integer  "uncertaincy"
    t.date     "start_sowing_date"
    t.date     "optimal_sowing_date"
    t.date     "end_sowing_date"
    t.date     "start_harvest_date"
    t.date     "optimal_harvest_date"
    t.date     "end_harvest_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.string  "crop"
    t.integer "average_predicted_yield"
    t.integer "uncertaincy"
    t.date    "start_sowing_date"
    t.date    "optimal_sowing_date"
    t.date    "end_sowing_date"
    t.date    "start_harvest_date"
    t.date    "optimal_harvest_date"
    t.date    "end_harvest_date"
  end

end
