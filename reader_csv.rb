def read_events file_name
 first_row = true
 names = []
 events = []
 CSV.foreach(file_name + ".csv") do |row|
   if first_row
     names = row
     first_row = false
   else
     event_hash = {}
     row.zip((0..(row.size - 1))).each do |field,position|
       if names[position] == "date"
         event_hash[names[position]] = Time.parse(field)
       elsif names[position] == "complexity"
         event_hash[names[position]] = field.to_f
       else
         event_hash[names[position]] = field
       end
     end
     events << CodeEvent.new(event_hash)
   end
 end
 events
end

