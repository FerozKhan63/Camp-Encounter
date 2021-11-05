class ExportToCsv
  def self.create_csv_file(attributes, model)
    CSV.generate(headers: true) do |csv|
      csv << attributes

      model.all.each do |u|
        csv << attributes.map{ |attr| u.send(attr) }
      end
    end

  end
end
