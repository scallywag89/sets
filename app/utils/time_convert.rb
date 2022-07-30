class TimeConvert

  def self.milliseconds_to_minutes_and_seconds(ms)
    total_seconds = (ms.to_f / 1000).round
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    return "#{minutes}m:#{'%02d' % seconds}s"
  end
end
