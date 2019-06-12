require 'soda'

class SodaLoader

  attr_accessor :client, :resource_uri, :reqd_cols

  def initialize
    @client = SODA::Client.new({:domain => "data.cityofchicago.org"})
    @resource_uri = "https://data.cityofchicago.org/resource/85ca-t3if.json"
    @reqd_cols = "crash_date,crash_day_of_week,crash_hour,crash_month,crash_type,injuries_fatal,injuries_incapacitating,injuries_no_indication,injuries_non_incapacitating,lighting_condition,prim_contributory_cause,rd_no"
  end

  def load_db(start_date, end_date, batch_size_perc = 0.1)

    total_data_hash = load_all_data(start_date, end_date, batch_size_perc)

    total_data_hash.each do |data_row|
      data = data_row.to_json
      record = Crash.new(JSON.parse(data))
      record.save
    end

    puts "Completed Successfully"

  end

  def load_all_data(start_date, end_date, batch_size_perc = 0.1)
    
    # Calculating the batch size needed to iterate
    total_num_records = @client.get(@resource_uri,
                                    {"$select" => "count(rd_no)",
                                     "$where" => "crash_date between '#{start_date}' and '#{end_date}'"})
    total_num_records = total_num_records.body.first.count_rd_no
    batch_size = (batch_size_perc*total_num_records.to_f).to_i
    
    # Beginning Iteration over Batches
    last_iter_num = (1/batch_size_perc).to_i + 1
    offset = 0
    total_data = load_batch_data(batch_size, offset)

    (1..last_iter_num).each do |iter_num| # EVS NOTE: REVISIT TO FIX
      offset = iter_num*batch_size
      puts iter_num
      puts total_data.length
      puts total_data.class
      total_data = total_data + load_batch_data(batch_size, offset)
    end
    return total_data
  end

  def load_batch_data(limit_size, offset)

    data_batch = @client.get(@resource_uri,
                            {"$select" => @reqd_cols, "$limit" => limit_size,
                              "$offset" => offset})
    
    return data_batch.body
  end
end