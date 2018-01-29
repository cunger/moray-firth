class BottlenoseDolphin
  attr_reader :id, :name, :birthyear, :birthmonth

  def initialize(id, name, birthyear, birthmonth=1)
    @id = id
    @name = name
    @birthyear = birthyear
    @birthmonth = birthmonth
    @status = :alive
  end

  def birthdate_string
    yy = birthyear.nil?  ? '' : birthyear.to_s
    mm = birthmonth.nil? ? '' : birthmonth.to_s
    if yy.empty?
      ''
    elsif mm.empty?
      yy
    else
      mm + '/' + yy
    end
  end

  def age
    return nil if birthyear.nil?

    today = Time.now
    today.year - birthyear - (Time.now.month < birthmonth ? 1 : 0)
  end

  def deceased!
    @status = :dead
  end

  def alive?
    @status == :alive
  end
end
