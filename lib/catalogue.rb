require 'csv'
require_relative 'bottlenose_dolphin'

class Catalogue
  def initialize
    @dolphins = []
  end

  def <<(dolphin)
    @dolphins << dolphin
  end

  def size
    @dolphins.size
  end

  def to_a
    @dolphins
  end

  def load
    CSV.foreach('lib/export/export_individuals.csv', headers: true) do |row|
      if row['birthyear'] == '2001/2002'
        row['birthyear'] = '2002'
      end # FIXME
      birthyear = row['birthyear'].nil? ? nil : Integer(row['birthyear'])
      birthmonth = parse_month(row['birthmonth'])

      dolphin = BottlenoseDolphin.new(Integer(row['id']), row['name'], birthyear)
      dolphin.deceased! if row['status'].downcase == 'dead'
      @dolphins << dolphin
    end
    @dolphins.sort! { |d1, d2| d1.id <=> d2.id }
  end

  private

  def parse_month(string)
    return 1 if string.nil?
    
    case string.downcase
    when /jan.*/ then 1
    when /feb.*/ then 2
    when /mar.*/ then 3
    when /apr.*/ then 4
    when /may.*/ then 5
    when /jun.*/ then 6
    when /jul.*/ then 7
    when /aug.*/ then 8
    when /sep.*/ then 9
    when /oct.*/ then 10
    when /nov.*/ then 11
    when /dec.*/ then 12
    else 1
    end
  end
end
