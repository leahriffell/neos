class Table
  def self.column_labels
    { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  end

  def self.column_data(asteroid_list)
    self.column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [asteroid_list.map { |asteroid| asteroid[col].size }.max, label.size].max}
    end
  end

  def self.header
    "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def self.divider
    "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def self.format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def self.create_rows(asteroid_data, column_info)
    rows = asteroid_data.each { |asteroid| format_row_data(asteroid, column_info) }
  end
  
end