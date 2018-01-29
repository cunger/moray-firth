require 'csv'

# Aux

def parse_id(string)
  Float(string).to_i
end

# Export

individuals = []
stiffs = {}

# Read from export

CSV.foreach('ID.csv', headers: true) do |row|
  individuals << {
    id: parse_id(row['ID #']),
    name: row['NAME'],
    birthyear: row['BIRTH YEAR'],
    birthmonth: row['BIRTH MONTH']
  }
end

CSV.foreach('Stiffs.csv', headers: true) do |row|
  stiffs[parse_id(row['ID'])] = row['STATUS']
end

# Clean up

# TODO

# Write to CSV


def status(string)
  if string.downcase == 'dead'
    :dead
  else
    :alive
  end
end

File.open('export_individuals.csv','w') { |f| f.write '' }
CSV.open('export_individuals.csv','w',
  write_headers: true,
  headers: ['id', 'name', 'birthyear', 'birthmonth', 'status']
) do |csv|
  individuals.each do |i|
    csv << [i[:id], i[:name], i[:birthyear], i[:birthmonth], stiffs.fetch(i[:id], 'alive')]
  end
end
