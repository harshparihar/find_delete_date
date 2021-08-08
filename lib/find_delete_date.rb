# frozen_string_literal: true

require_relative "find_delete_date/version"
require 'date'

module FindDeleteDate
  class Error < StandardError; end


  class Calculate
    PLANS =  {
      standard: {
        days: 42
      },
      gold: {
        days: 42,
        months: 365
      },
      platinum: {
        days: 42,
        months: 365,
        years: 7*365
      }
    }

    def self.last_date?(date, end_date)
      date == end_date
    end


    def self.add_days(name, date, duration_type)
      date + PLANS[name][duration_type]
    end

    def self.delete_date(name, date)
      delete_date = nil
      day = date.day
      month = date.month
      year = date.year
      month_end = Date.civil(year, month, -1)
      year_end = Date.civil(year, -1, -1)

      case name
      when :standard
        delete_date = add_days(name, date, :days)
      when :gold
        delete_date = last_date?(date, month_end) ? add_days(name, date, :months) : add_days(name, date, :days)
      when :platinum
        delete_date = if last_date?(date, year_end)
                        add_days(name, date, :years)
                      elsif last_date?(date, month_end)
                        add_days(name, date, :months)
                      else
                        add_days(name, date, :days)
                      end
      else
        puts "Please provide Plan name"
      end
      delete_date
    end
  end

end
